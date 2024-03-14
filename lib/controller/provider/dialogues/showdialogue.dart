import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../apicallsProvider/api_get_function.dart';
import '../apicallsProvider/commonapicallprovider.dart';

getError(String error, BuildContext ctx) {
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        error,
        style: const TextStyle(color: Colors.white),
      )));
}

class DialoguesProvider extends ChangeNotifier {
  Future<Widget> getLoading() async {
    return const Center(
      child: Column(
        children: [
          SpinKitPouringHourGlass(
            color: Colors.white,
            size: 50.0,
          ),
          Text(
            "Loading...",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  deletionDialogue(BuildContext context, int index) async {
    final provider = Provider.of<ApiGetMoviesProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SizedBox(
              height: 94,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Do you want to Delete this Movie',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    sizedH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              await Provider.of<ApicallFunction>(context,
                                      listen: false)
                                  .deleteApicall(provider.movieList[index].id!,
                                      index, context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: const Text('Delete')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  lottieshowing(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SizedBox(
            height: 30,
            width: 20,
            child: Lottie.asset("assets/animations/animation_lk15dry5.json"));
      },
    );
  }

  deletionBannerDialogue(BuildContext context, int index) async {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: textFieldBackground,
          children: [
            SizedBox(
              height: 94,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Do you want to Delete this Banner',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: textwhite),
                    ),
                    sizedH10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            child: const Text('Delete')),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No'))
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
