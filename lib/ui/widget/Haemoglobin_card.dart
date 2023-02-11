import 'package:flutter/material.dart';
import 'package:onlinediagnostic_nurse/ui/widget/custombutton.dart';

class Haemoglobin extends StatelessWidget {
  final String title;
  const Haemoglobin({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black26,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      Text("pending"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text("32"),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Male"),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "Location",
                              ),
                              Text(
                                "Location",
                              ),
                            ],
                          ),
                        ],
                      ),
                      Material(
                        color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Done",
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
