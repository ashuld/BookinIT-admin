// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:convert';

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:appadmin/view/dashbord/homepage.dart';
import 'dart:developer';
import 'package:appadmin/serverSide/apiConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool isLoading = false;

  Future loginAdmin(
      {required String email,
      required String password,
      required BuildContext context}) async {
// bool  isLoading=false;
    String error;
    // Map <String,dynamic>payload={
    //   "password":password,
    //   "email":email
    // };
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        http.Response response;

        response = await http
            .post(Uri.parse(ApiConfiguration.baseUrl + ApiConfiguration.login),
                // headers: ,
                body: {"password": password, "email": email});
        log(response.body);
        log("${response.statusCode}");
        if (response.statusCode == 201) {
          Map<String, dynamic> tokenSaver = jsonDecode(response.body);
          String token = tokenSaver["token"];
          log(token);
          secureStorage.write(key: "Token", value: token);

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AdminHomePage(),
              ));
          final jsonerespond = jsonDecode(response.body);

          log(jsonerespond);
          isLoading = false;
          notifyListeners();
          return jsonerespond;
        } else {
          error = "Api response didint get";

          log(getError(error, context));
          getError(error, context);
        }
      }
    } catch (e) {
      log(e.toString());
// log( getError(error, context));
    }
  }

  // Future getlogged() async{
  //  await setlogged(value)
  // }
}
