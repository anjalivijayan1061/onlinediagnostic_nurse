import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinediagnostic_nurse/ui/screen/home_screen_sections/report_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screen/home_screen_sections/settings_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screen/home_screen_sections/test_screen.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../blocs/orders/orders_bloc.dart';
import '../newtest_screen.dart';
import '../signin_screen.dart';
import 'members_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final OrdersBloc ordersBloc = OrdersBloc();

  @override
  void initState() {
    Future.delayed(
      const Duration(
        milliseconds: 100,
      ),
      () {
        if (Supabase.instance.client.auth.currentUser == null) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const SigninScreen(),
            ),
            (route) => true,
          );
        }
      },
    );

    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
    ordersBloc.add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrdersBloc>.value(
      value: ordersBloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            "Online Diagnostic",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
          ),
          backgroundColor: Colors.white,
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: const [
            TestScreen(),
            SettingsScreen(),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavBarItem(
                  icon: Icons.home,
                  label: 'Tests',
                  isSelected: tabController!.index == 0,
                  onTap: () {
                    ordersBloc.add(GetOrdersEvent());
                    tabController!.animateTo(0);
                    setState(() {});
                  },
                ),
                NavBarItem(
                  label: 'Settings',
                  icon: Icons.settings,
                  isSelected: tabController!.index == 1,
                  onTap: () {
                    tabController!.animateTo(1);
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final Function() onTap;
  const NavBarItem({
    Key? key,
    this.isSelected = false,
    required this.icon,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue : Colors.black,
            size: 25,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isSelected ? Colors.blue : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          )
        ],
      ),
    );
  }
}



// class TestCard1 extends StatelessWidget {
//   final bool isActive;
//   final String date, status;

//   const TestCard1({
//     Key? key,
//     required this.date,
//     required this.status,
//     this.isActive = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Material(
//         color: Colors.white,
//         shape: const RoundedRectangleBorder(
//           side: BorderSide(
//             color: Colors.black26,
//             width: 1,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     date,
//                   ),
//                   Text(
//                     status,
//                     style: const TextStyle(color: Colors.green),
//                   ),
//                 ],
//               ),
//               const Divider(),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Test 1',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Test 2',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   'Test 3',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Text(
//                   '3 more test ',
//                   textAlign: TextAlign.center,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(fontSize: 15),
//                 ),
//               ),
//               isActive
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('Total-550',
//                           textAlign: TextAlign.center,
//                           overflow: TextOverflow.ellipsis,
//                           style:
//                               TextStyle(fontSize: 15, color: Colors.red[600])),
//                     )
//                   : const SizedBox(),
//               const Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Icon(
//                     Icons.document_scanner,
//                     color: Colors.blue[400],
//                   ),
//                   const Text(
//                     'View Document',
//                     textAlign: TextAlign.center,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 15,
//                     ),
//                   ),
//                   ElevatedButton(
//                     child: const Text('Details'),
//                     onPressed: () {},
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.blue[400],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
