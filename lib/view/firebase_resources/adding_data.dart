

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:typed_data';

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

final FirebaseStorage _storage=FirebaseStorage.instance;
final FirebaseFirestore _firestore=FirebaseFirestore.instance;

class StorageData {

 
 Future<String>uploadImageToStorage(String childName,Uint8List file) async{
  
   Reference reference=_storage.ref().child(childName);

   UploadTask uploadTask=reference.putData(file);

   TaskSnapshot snapshot=await uploadTask;
   String downloadUrl =await snapshot.ref.getDownloadURL();
   return downloadUrl;

 }


 Future<String> saveData({required String name,required String description,required Uint8List file,required BuildContext context}) async{
    String resp="error occured";
try {
  if (name.isNotEmpty ||description.isNotEmpty) {
    
 String imageUrl=await uploadImageToStorage(name, file);
  log("datas reach");
 await _firestore.collection("MovieBanner").add({
  'MovieName':name,
  'Description':description,
  'imageLink':imageUrl,
 });
 log("datas reach");
 getError("Filim added", context);
 Navigator.pop(context);
 resp="success";
  }
} catch (e) { 
   resp=e.toString();
   log(resp);
}
  return resp;



 }
}