import 'package:flutter/material.dart';

import '../../widget/test_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TestCard(date: "12/03/2022", status: "Accepted", name: "John"),
              TestCard(date: "14/03/2022", status: "Pending", name: "Rani"),
              TestCard(date: "15/03/2022", status: "Accepted", name: "Lena"),
            ],
          ),
        ),
      ),
    );
  }
}
