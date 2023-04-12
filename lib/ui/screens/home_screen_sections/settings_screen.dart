import 'package:flutter/material.dart';
import 'package:onlinediagnostic_nurse/ui/screens/about_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/complaints_screen.dart';
import 'package:onlinediagnostic_nurse/ui/screens/signin_screen.dart';
import 'package:onlinediagnostic_nurse/ui/widget/custom_button.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool signOut = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutScreen(),
                ),
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
          ListTile(
            leading: const Icon(
              Icons.dangerous,
            ),
            title: const Text('Complaints'),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ComplaintsScreen(),
                ),
              );
            },
          ),
          const Divider(),
          CustomButton(
            iconData: Icons.exit_to_app_outlined,
            label: signOut ? 'Signingout...' : 'Signout',
            onPressed: () async {
              signOut = true;
              setState(() {});
              await Supabase.instance.client.auth.signOut();
              signOut = false;
              setState(() {});

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const SigninScreen(),
                ),
                (route) => true,
              );
            },
          ),
        ],
      ),
    );
  }
}
