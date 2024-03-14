import 'package:appadmin/controller/provider/FilimSection/filim_adding.dart';
import 'package:appadmin/controller/provider/apicallsProvider/api_get_function.dart';
import 'package:appadmin/controller/provider/apicallsProvider/commonapicallprovider.dart';
//import 'package:appadmin/controller/provider/biometricProvider/biometric_provider.dart';
import 'package:appadmin/controller/provider/debouncer/debouncer.dart';
import 'package:appadmin/controller/provider/users_controller/manage_users_controller.dart';
import 'package:appadmin/controller/provider/voucher_provider/voucher_provider.dart';
import 'package:appadmin/core/colors.dart';
import 'package:appadmin/controller/provider/loginpage/loginPageProvider.dart';
import 'package:appadmin/view/splashScreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'controller/provider/dialogues/showdialogue.dart';
import 'controller/provider/firebase_provider/firebase_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FilimAddingPrvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DebouncerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DialoguesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApicallFunction(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApiGetMoviesProvider(),
        ),
        //  ChangeNotifierProvider(create:(context) => BioMetricProvider(), ),
        ChangeNotifierProvider(
          create: (context) => FirebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VoucherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ManageUsersController(),
        )
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
        );
      }),
    );
  }
}
