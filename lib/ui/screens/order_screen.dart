import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:onlinediagnostic_nurse/ui/screens/order_screen.dart';

import '../widget/test_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TestCard(
                      date: "12/03/2022", status: "Accepted", name: "John")),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TestCard(
                    date: "14/03/2022", status: "Pending", name: "Rani"),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TestCard(
                    date: "15/03/2022", status: "Accepted", name: "Lena"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
