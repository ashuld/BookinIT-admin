// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';

import 'package:appadmin/view/firebase_resources/adding_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../view/banner_Page/banner_homepage.dart';
import '../dialogues/showdialogue.dart';

class FirebaseProvider extends ChangeNotifier {
  TextEditingController movieNameController = TextEditingController();
  TextEditingController movieDescriptionController = TextEditingController();
  final key = GlobalKey<FormState>();

  dynamic imagePath;
  String? displayImage;
  bool images = false;
  List<QueryDocumentSnapshot<Object?>>? snapshotList;
  List<MovieBannerDetails> bannerList = [];

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);

    imagePath = img;
    images = true;
    notifyListeners();
  }

  saveImageData(BuildContext context) async {
    String movieName = movieNameController.text;
    String description = movieDescriptionController.text;

    String resp = await StorageData().saveData(
        name: movieName,
        description: description,
        file: imagePath,
        context: context);

    //if
    return resp;
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    final file = await _imagePicker.pickImage(source: source);
    if (file != null) {
      displayImage = file.path;
      log(displayImage.toString());
      notifyListeners();
      return await file.readAsBytes();
    } else {
      log("no image Selected");
    }
  }

  Future<void> deleteData(BuildContext context, int index) async {
    try {
      final id = snapshotList![index].id;
      Navigator.of(context).pop();
      await FirebaseFirestore.instance
          .collection('MovieBanner')
          .doc(id)
          .delete();
      notifyListeners();
      getError(
        'Successfully deleted Movie Banner',
        context,
      );
    } catch (e) {
      getError(
        e.toString(),
        context,
      );
    }
  }

  valueAdding(AsyncSnapshot<QuerySnapshot<Object?>>? snapshot) {
    List<QueryDocumentSnapshot<Object?>>? list = snapshot?.data?.docs.toList();
    snapshotList = list;
    bannerList.clear();
    for (var datas in list!) {
      final banners = MovieBannerDetails(
          imagePath: datas['imageLink'],
          movieDescription: datas['Description'],
          moviName: datas['MovieName']);
      bannerList.add(banners);
    }
    notifyListeners();
  }
}
