// ignore_for_file: non_constant_identifier_names, file_names

import 'package:appadmin/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/sizedBox.dart';
import '../../controller/provider/dialogues/showdialogue.dart';
import '../../controller/provider/loginpage/loginPageProvider.dart';
import '../widgets/textFormFIeld1.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    //final provider2=Provider.of<>(context);

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              sizedH120,
              const Center(
                  child: Text(
                'Welcome',
                style: TextStyle(color: textwhite, fontSize: 60),
              )),
              const Text(
                'ramees you just login',
                style: TextStyle(color: textwhite, fontWeight: FontWeight.w100),
              ),
              sizedH60,

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField1(
                  hintText: 'Email',
                  textController: provider.userNameController,
                  textIcon: Icons.person,
                ),
              ),
              sizedH10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField1(
                  hintText: 'password',
                  textController: provider.passWordController,
                  textIcon: Icons.password,
                ),
              ),
              sizedH60,
              SizedBox(
                height: 50,
                width: size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () async {
                    if (provider.formKey.currentState!.validate()) {
                      // provider.isLoading==true ? getLoading() : provider.loginAdmin(email: provider.userNameController.text, password: provider.passWordController.text, context: context);

                      await provider.loginAdmin(
                          email: provider.userNameController.text.trim(),
                          password: provider.passWordController.text.trim(),
                          context: context);
                      setlogged(value: true);

                      // ignore: use_build_context_synchronously
                    } else {
                      getError("field Not filled", context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: buttonColor,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: textwhite, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              //   sizedH30,
              // const  Text("Or",style: TextStyle(color:textwhite),),
              // sizedH30,
              // TextButton(onPressed: (){
              //  // Navigator.push(context, MaterialPageRoute(builder: (context) =>const SighnUpPage() ,));
              // }, child:const Text("sighnin?",style: TextStyle(color: textwhite),))
            ],
          ),
        ),
      ),
    );
  }
}

Future setlogged({required bool value}) async {
  final SharedPreferences shared_preferences =
      await SharedPreferences.getInstance();
  shared_preferences.setBool("login", value);
}
