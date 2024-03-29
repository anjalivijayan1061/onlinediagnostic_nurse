import 'package:flutter/material.dart';

import '../../../blocs/complaint/complaint_bloc.dart';
import '../../../blocs/orders/orders_bloc.dart';
import '../../../util/get_date.dart';
import '../../screen/test_details_screen.dart';
import '../custom_alert_dialog.dart';
import '../custom_button.dart';
import '../custom_icon_button.dart';

class ComplaintCard extends StatelessWidget {
  final Map<String, dynamic> complaintDetails;
  final ComplaintBloc complaintBloc;
  const ComplaintCard({
    super.key,
    required this.complaintDetails,
    required this.complaintBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDate(DateTime.parse(
                      complaintDetails['complaint']['created_at'])),
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.black,
                      ),
                ),
                CustomIconButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        title: 'Are you sure',
                        message:
                            'Are you sure you want to delete this complaint? This action cannot be undone',
                        primaryButtonLabel: 'Delete',
                        primaryOnPressed: () {
                          complaintBloc.add(
                            DeleteComplaintEvent(
                              complaintId: complaintDetails['complaint']['id'],
                            ),
                          );

                          Navigator.pop(context);
                        },
                        secondaryButtonLabel: 'Cancel',
                        secondaryOnPressed: () => Navigator.pop(context),
                      ),
                    );
                  },
                  icon: Icons.delete_forever_outlined,
                  iconColor: Colors.red,
                ),
              ],
            ),
            const Divider(
              color: Colors.black38,
            ),
            Text(
              complaintDetails['complaint']['complaint'],
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            const Divider(
              color: Colors.black38,
            ),
            CustomButton(
              height: 45,
              label: 'Test Details',
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => TestDetailsScreen(
                    testDetails: complaintDetails['test'],
                    ordersBloc: OrdersBloc(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
