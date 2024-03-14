import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/view/user_section/widgets/cinepass_search.dart';
import 'package:appadmin/view/user_section/widgets/cinepass_user_cards.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/users_controller/manage_users_controller.dart';
import '../../core/colors.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController =
        Provider.of<ManageUsersController>(context, listen: false);
    final searchUserController = TextEditingController();
    Provider.of<ManageUsersController>(context, listen: false).getAllUsers();
   // final appBar = CinePassAppBar();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: backgroundColor),
        child: Scaffold(
            appBar:AppBar(
              backgroundColor: backgroundColor,
              title:const Text('Manage Users',style: TextStyle(color: textwhite),),) ,
               
            body: Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                 sizedH20,
                  CinePassSearchField(
                    controller: searchUserController,
                    function: (searchUserController) =>
                        userController.searchUser(searchUserController),
                    clearingFunction: () {
                      searchUserController.clear();
                      userController.searchUser('');
                    },
                    hint: 'Search User',
                  ),
                  sizedH20,
                  Expanded(
                    child: Consumer<ManageUsersController>(
                      builder: (context, value, child) {
                        return value.users.isNotEmpty
                            ? ListView.separated(
                                padding:
                                   const EdgeInsets.only(bottom: 1),
                                itemBuilder: (context, index) {
                                  return CinePassUserCard(
                                    userName:
                                        value.searchedUsersList[index].signName,
                                    userMail: value
                                        .searchedUsersList[index].signEmail,
                                    userPhone: value
                                        .searchedUsersList[index].signPhone
                                        .toString(),
                                    userID: value.searchedUsersList[index].id,
                                    // isBlocked:
                                    //     value.searchedUsersList[index].block,
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return sizedH10;
                                },
                                itemCount: value.searchedUsersList.length,
                              )
                            : const Center(
                                child: Text(
                                  'User not found!',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              );
                      },
                    ),
                  )
                ],
              ),
            )));
  }
}
