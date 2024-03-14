// ignore_for_file: use_build_context_synchronously

import 'package:appadmin/view/dashbord/homepage.dart';
import 'package:appadmin/view/loginPage/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/provider/apicallsProvider/api_get_function.dart';
//import '../../controller/provider/biometricProvider/biometric_provider.dart';
import '../../controller/provider/users_controller/manage_users_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ApiGetMoviesProvider>(context, listen: false).apiGet(context);
    getlogged(context);
    Provider.of<ManageUsersController>(context, listen: false).getAllUsers();

    // Provider.of<BioMetricProvider>(context,listen: false).biometricVerification(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: 50,
            // width: 50,
            child: Lottie.asset('assets/animations/animation_lk3hiyoo.json',
                fit: BoxFit.cover, repeat: false)),
      ),
    );
  }

  showingScreen(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
  }

  Future<void> getlogged(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    bool? value = sharedPreferences.getBool('login');

    if (value == true) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AdminHomePage(),
          ));
    } else {
      await showingScreen(context);
    }
  }
}
