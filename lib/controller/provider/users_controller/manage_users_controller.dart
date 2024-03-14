// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:appadmin/serverSide/filimgeting/filim_getting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../model/user_model/user_model.dart';

class ManageUsersController extends ChangeNotifier {
  List<UserModel> users = [];
  List<UserModel> searchedUsersList = [];

  Future<void> getAllUsers() async {
    searchedUsersList.clear();
    const storage = FlutterSecureStorage();
    final _token = await storage.read(key: 'Token');
    final response = await ApiServices().getAPIWithToken('adminuser', _token!);
    final status = jsonDecode(response.body) as Map<String, dynamic>;
    users = List<UserModel>.from(status['data'].map((e) {
      UserModel userModel = UserModel.fromJson(e);
      searchedUsersList.add(userModel);
      return userModel;
    }));
    log(searchedUsersList.toString()
);
    notifyListeners();
  }

  void searchUser(String query) {
    searchedUsersList.clear();
    for (UserModel userModel in users) {
      if (userModel.signName.toLowerCase().contains(query.toLowerCase())) {
        searchedUsersList.add(userModel);
      }
      notifyListeners();
    }
  }

  Future<void> blockUser(BuildContext context, String userID) async {
    try {
      const storage = FlutterSecureStorage();
      final _token = await storage.read(key: 'Token');
      final response = await ApiServices()
          .postAPIWithToken('block-user', _token!, {"userId": userID});
      log(response.body);
      await getAllUsers();
      Navigator.of(context).pop();
      getError( 'Blocked User Successfully!',context,);
    } catch (e) {
      Navigator.of(context).pop();
      getError( e.toString(),context,);
    }
  }

  // Future<void> unblockUser(BuildContext context, String userID) async {
  //   try {
  //     const storage = FlutterSecureStorage();
  //     final _token = await storage.read(key: 'token');
  //     final response = await APIServices()
  //         .postAPIWithToken('unblock-user', _token!, {"userId": userID});
  //     log(response.body);
  //     await getAllUsers();
  //     Navigator.of(context).pop();
  //     successSnackBar(context, 'Unblocked User Successfully!');
  //   } catch (e) {
  //     Navigator.of(context).pop();
  //     errorSnackBar(context, e.toString());
  //   }
  // }
}
