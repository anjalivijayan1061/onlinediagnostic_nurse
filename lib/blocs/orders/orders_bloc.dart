import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState()) {
    on<OrdersEvent>((event, emit) async {
      emit(OrdersLoadingState());
      try {
        SupabaseClient supabaseClient = Supabase.instance.client;
        SupabaseQueryBuilder queryTable = supabaseClient.from('test_bookings');
        if (event is GetOrdersEvent) {
          List<dynamic> tempOrders = await supabaseClient.rpc(
            'get_test_bookings',
            params: {
              // 'search_status': event.status,
              'search_nurse_id': supabaseClient.auth.currentUser!.id,
              // 'search_patient_id': event.patientId,
            },
          );

          List<Map<String, dynamic>> searchableOrders =
              tempOrders.map((e) => e as Map<String, dynamic>).toList();

          List<Map<String, dynamic>> orders = [];

          for (int i = 0; i < searchableOrders.length; i++) {
            if (event.status == 'pending') {
              if (searchableOrders[i]['status'] == 'pending' ||
                  searchableOrders[i]['status'] == 'collected') {
                orders.add(searchableOrders[i]);
              }
            } else {
              if (searchableOrders[i]['status'] == 'complete') {
                orders.add(searchableOrders[i]);
              }
            }
          }
          Logger().w(orders);

          emit(OrdersSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          Map<String, dynamic> data = {
            'user_id': supabaseClient.auth.currentUser!.id,
            'patient_id': event.patientId,
          };

          if (event.prescription != null) {
            String path = await supabaseClient.storage.from('docs').upload(
                'prescriptions/${DateTime.now().millisecondsSinceEpoch.toString()}${event.prescription!.name}',
                File(event.prescription!.path!));

            path = path.replaceRange(0, 5, '');

            Logger().wtf(path);

            data['prescription_document'] =
                supabaseClient.storage.from('docs').getPublicUrl(path);
            data['can_pay'] = false;
          }

          Map<String, dynamic> order =
              await queryTable.insert(data).select().single();

          if (event.tests.isNotEmpty) {
            List<Map<String, dynamic>> orderItems = [];
            for (int i = 0; i < event.tests.length; i++) {
              orderItems.add(
                {
                  'test_booking_id': order['id'],
                  'test_id': event.tests[i]['id'],
                  'price': event.tests[i]['price'],
                },
              );
            }
            await supabaseClient.from('test_booking_item').insert(orderItems);
          }

          add(GetOrdersEvent());
        } else if (event is PaymentOrderEvent) {
          await queryTable.update({
            'payment_status': 'paid',
            'payment_id': event.paymentId,
          }).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is ChangeOrderStatusEvent) {
          await queryTable.update({
            'status': event.status,
          }).eq('id', event.orderId);
          add(GetOrdersEvent());
        } else if (event is DeleteOrderEvent) {
          await queryTable.delete().eq('id', event.orderId);
          add(GetOrdersEvent());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrdersFailureState());
      }
    });
  }
}
