// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:appadmin/controller/provider/debouncer/debouncer.dart';
import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/model/filimAdding/filimresp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../controller/provider/FilimSection/filim_adding.dart';
import '../../../controller/provider/apicallsProvider/api_get_function.dart';
import '../../../model/filimposting/filim_posting.dart';
import '../../../serverSide/filimgeting/filim_getting.dart';

// ignore: must_be_immutable
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  List<SearchResult> displayList = [];

  List<SearchResult> suggestion = [];

  final DebouncerProvider _debouncerProvider = DebouncerProvider();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilimAddingPrvider>(context, listen: false);

    //  bool showBox=true;

    // final dialogueProvider=Provider.of<DialoguesProvider>(context,listen: false);
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            sizedH10,
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: searchController,
                style: const TextStyle(color: textwhite),
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                    hintText: "Search Movie",
                    prefixIcon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    hintStyle: const TextStyle(
                      color: Colors.white38,
                      textBaseline: TextBaseline.alphabetic,
                    ),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    fillColor: Colors.white70.withOpacity(0.1)),
                onChanged: (value) {
                  _debouncerProvider.run(() async {
                    displayList.clear();
                    displayList = await provider.filimGetting(
                        searchController.text, context);
                    //   log('${displayList}');
                    suggestion =
                        provider.displaying(searchController.text, displayList);

                    //   log('ethiyoo${suggestion}');
                  });
                },
              ),
            ),
            Expanded(
              child: Consumer<FilimAddingPrvider>(
                  builder: (context, value, child) {
                return ListView.builder(
                  itemCount: suggestion.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          searchController.text =
                              suggestion[index].originalTitle.toString();

                          await messageDialogues(
                              suggestion[index].originalTitle!, context);
                        },
                        child: ListTile(
                          //  leading:CircleAvatar(
                          //   radius: 25,
                          //   backgroundImage: NetworkImage(value.list[index].posterPath.toString()),

                          title: Text(
                            suggestion[index].originalTitle.toString(),
                            style: const TextStyle(color: textwhite),
                          ),
                        ));
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

messageDialogues(String movieName, BuildContext context) async {
  final providerGet = Provider.of<ApiGetMoviesProvider>(context, listen: false);
  final provider = Provider.of<FilimAddingPrvider>(context, listen: false);

  // FilimAddingPrvider filimAddingPrvider=FilimAddingPrvider();
  // int index=0;
  List<MovieDetails> movieInfo = [];
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Do You Want to Add ${movieName}Movie",
            style: const TextStyle(
                color: blackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            InkWell(
                onTap: () async {
//Provider.of<DialoguesProvider>(context,listen: false).lottieshowing(context);
                  movieInfo =
                      await ApiServices().searchGetting(context, movieName);
                  log(movieInfo.toString());
                  await provider.filimPost(movieInfo, context);
                  await providerGet.apiGet(context);
                  await successAlert(context, movieName);
                  Navigator.pop(context);
                  Navigator.pop(context);

                  // log('${providerGet.movieList[0].id}');
                },
                child: const Text(
                  'Add',
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                )),
            TextButton(
                onPressed: () {
                  //   providerGet.apiGet(context);
                  Navigator.pop(context);
                },
                child:
                    const Text("Cancel", style: TextStyle(color: blackColor)))
          ],
        );
      }
// ignore: must_be_immutable
      );
}

successAlert(BuildContext context, String text) async {
  await showDialog(
    context: context,
    builder: (context) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        FutureBuilder(
          future: textFunction(name: text),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data as Widget;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]);
    },
  );
}

Future<Widget> textFunction({required String name}) async {
  await Future.delayed(const Duration(seconds: 3));
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Lottie.asset('assets/animations/success.json', repeat: false),
      Text(
        '$name Movie Added',
        style: const TextStyle(color: textwhite),
      ),
    ],
  );
}
