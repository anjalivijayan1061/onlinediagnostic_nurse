part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class GetOrdersEvent extends OrdersEvent {
  final String status;
  final int? patientId;

  GetOrdersEvent({
    this.status = 'pending',
    this.patientId,
  });
}

class AddOrderEvent extends OrdersEvent {
  final int patientId;
  final PlatformFile? prescription;
  final List<Map<String, dynamic>> tests;

  AddOrderEvent({
    required this.patientId,
    this.prescription,
    required this.tests,
  });
}

class ChangeOrderStatusEvent extends OrdersEvent {
  final int orderId;
  final String status;

  ChangeOrderStatusEvent({
    required this.orderId,
    required this.status,
  });
}

class DeleteOrderEvent extends OrdersEvent {
  final int orderId;

  DeleteOrderEvent({required this.orderId});
}

class PaymentOrderEvent extends OrdersEvent {
  final int orderId;
  final String paymentId;

  PaymentOrderEvent({
    required this.orderId,
    required this.paymentId,
  });
}
