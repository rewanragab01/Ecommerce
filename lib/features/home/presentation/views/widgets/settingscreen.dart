import 'package:ecommerce/features/auth/data/models/repos/authrepo.dart';
import 'package:ecommerce/features/auth/presentation/views_model/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final authrepository = AuthRepository(_firebaseAuth);

    return BlocProvider(
      create: (context) => AuthCubit(authrepository),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSignOutSuccess) {
              Navigator.pushNamed(context, '/login');
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.key_sharp),
                  title: const Text(
                    'Change Password',
                  ),
                  onTap: () => Navigator.pushNamed(context, '/changepassword'),
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  height: 20,
                  color: Colors.grey,
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text('Logout'),
                  onTap: () {
                    _showLogoutDialog(context, context.read<AuthCubit>());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Make the method static
  static void _showLogoutDialog(BuildContext context, AuthCubit authCubit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure that you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                // Trigger the sign-out process
                authCubit.signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
