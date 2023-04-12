import 'package:flutter/material.dart';
import 'package:onlinediagnostic_nurse/ui/screens/home_screen_sections/settings_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/home_screen_sections/test_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/notification_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/home_screen_sections/order_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/signin_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

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
      length: 3,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        title: Text(
          "Online Diagnostic",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.notifications_active_outlined,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          TestScreen(),
          OrderScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Material(
        color: const Color(0xFFBFE4F9),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavBarItem(
                icon: Icons.home,
                isSelected: tabController!.index == 0,
                onTap: () {
                  tabController!.animateTo(0);
                  setState(() {});
                },
              ),
              NavBarItem(
                icon: Icons.shopping_basket,
                isSelected: tabController!.index == 1,
                onTap: () {
                  tabController!.animateTo(1);
                  setState(() {});
                },
              ),
              NavBarItem(
                icon: Icons.settings,
                isSelected: tabController!.index == 2,
                onTap: () {
                  tabController!.animateTo(2);
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final Function() onTap;
  const NavBarItem({
    Key? key,
    this.isSelected = false,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: isSelected ? const Color(0xFF3E89B2) : Colors.black,
        size: 35,
      ),
    );
  }
}
