// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/view/widgets/textFormFIeld1.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/dialogues/showdialogue.dart';
import '../../controller/provider/firebase_provider/firebase_provider.dart';

class AddBannerPage extends StatelessWidget {
  const AddBannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider=Provider.of<FirebaseProvider>(context,listen: false);
     final providerDialogue=Provider.of<DialoguesProvider>(context,listen: false);
    final Size size=MediaQuery.of(context).size;
    return  Scaffold(
      
      body: SingleChildScrollView(
        child: Form(
          key: provider.key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sizedH120,
               Center(
                 child: InkWell(
                  onTap: () {
                  provider.selectImage();
                  },
                   child: Consumer<FirebaseProvider>(
                     builder: (context,data,child) {
                       return Container(
                        width:size.width*0.8 ,
                        height: size.height*0.4,
                        decoration: BoxDecoration(
                          color:  Colors.transparent,
                          border: Border.all(color: Colors.white70),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        
                        child:data.displayImage==null? Lottie.asset("assets/animations/cloud image.json"):Image.file(File(data.displayImage!),fit: BoxFit.cover,),
                       );
                     }
                   ),
                 ),
               ),
               sizedH30,
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField1(hintText: "Movie Name", textController: provider.movieNameController, textIcon:Icons.movie ),
               ),
            sizedH20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField1(hintText:"Movie Description", textController: provider.movieDescriptionController, textIcon:Icons.movie_edit ),
            ),
            sizedH120
            ],
          ),
        ),
      ),
       floatingActionButton:SizedBox(
        width: size.width*0.9,
        child: FloatingActionButton(onPressed: ()async{
          if (provider.key.currentState!.validate()) {
            
          providerDialogue.lottieshowing(context);
         await provider.saveImageData(context);
         Navigator.pop(context);
         provider.displayImage=null;
          }else{
            getError("please validate the forms", context);
          }
        },
        backgroundColor:buttonColor ,
        child:const Text("Add Banner",style: TextStyle(color: textwhite),),
        ),
      ) ,
    );
  }
}