// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, prefer_const_constructors

import 'package:appadmin/view/banner_Page/banner_homepage.dart';
import 'package:appadmin/view/vouchers/voucher_home_page.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../core/sizedBox.dart';
import '../filimadding/filim_adding.dart';
import '../user_section/user_section_screen.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SafeArea(
            child: SizedBox(
              height: 50,
              child: Text(
                'Admin Home page',
                style: TextStyle(
                    color: textwhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 30,
                ),
                children: <Widget>[
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilimAdding(),
                        )),
                    child: const GridviewCard(
                      image: 'assets/images/filimaAdding.gif',
                      name: 'Filim Adding',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VouchersHomepage(),
                        )),
                    child: GridviewCard(
                      image: 'assets/images/Vouchers.gif',
                      name: 'Vouchers',
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BannerHome(),
                        )),
                    child: const GridviewCard(
                      image: 'assets/images/bannerimage.gif',
                      name: 'Banner',
                    ),
                  ),
                  // const  GridviewCard(
                  //     image: 'assets/images/revenue(1).png',
                  //     name: 'Revenue',
                  //   ),

                  InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ManageUsersScreen(),
                          ));
                    },
                    child: const GridviewCard(
                      image: 'assets/images/user2.png',
                      name: 'Users',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GridviewCard extends StatelessWidget {
  const GridviewCard({
    Key? key,
    required this.image,
    required this.name,
  }) : super(key: key);

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: textFieldBackground, borderRadius: BorderRadius.circular(10)
          //  image: DecorationImage(image: AssetImage(image))
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: size.height * 0.1,
            width: size.width * 0.2,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
          ),
          sizedH10,
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
