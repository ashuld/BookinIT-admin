
// ignore_for_file: use_build_context_synchronously

import 'package:appadmin/core/colors.dart';
import 'package:appadmin/core/sizedBox.dart';
import 'package:appadmin/view/banner_Page/add_banner_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/dialogues/showdialogue.dart';
import '../../controller/provider/firebase_provider/firebase_provider.dart';


class BannerHome extends StatelessWidget {
  const BannerHome({super.key});

  @override
  Widget build(BuildContext context) {
   // final Size size=MediaQuery.of(context).size;
   
    final provider=Provider.of<FirebaseProvider>(context,listen: false);
     Size sized=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(Icons.arrow_back_ios,color: textwhite,)),
        title:const Text("Banner Page",style: TextStyle(color: textwhite,fontWeight: FontWeight.bold),),
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("MovieBanner").snapshots(),
              builder: (context, snapshot){
               
                 if (snapshot.connectionState == ConnectionState.done ||
                       snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                  
               provider.valueAdding(snapshot);
            
              
              return Consumer<FirebaseProvider>(
                builder: (context,data,child) {
                  return Expanded(
                    child: ListView.separated(
                     itemBuilder: (context, index) {
                       return FilimBanner(
                         movieImage: data.bannerList[index].imagePath,
                          movieName: data.bannerList[index].moviName,
                           movieDetails: data.bannerList[index].movieDescription,
                           index: index
                           );
                     },
                      separatorBuilder:(context, index) => sizedH10,
                       itemCount: data.bannerList.length 
                       ),
                  );
                }
              );
              }
                else{
                     return getError("smothingwent wrong", context);
                     
                       
                       
              }
                       }else{
                     return const Center(child: CircularProgressIndicator());
                       }
              
             }
              
            ),
            sizedH60
          ],
        ),
        
      ),
       floatingActionButton:SizedBox(
        width: sized.width*0.9,
        child: FloatingActionButton(onPressed: (){
           provider.movieDescriptionController.clear();
           provider.movieNameController.clear();
           
           Navigator.push(context, MaterialPageRoute(builder: (context) =>const AddBannerPage(),));
        },
        backgroundColor:buttonColor ,
        child:const Text("Add Banner",style: TextStyle(color: textwhite),),
        ),
      ) ,
    );
  }
}

class FilimBanner extends StatelessWidget {
  const FilimBanner({
    super.key,
     required this.movieImage, required this.movieName, required this.movieDetails, required this.index,
  });

  final String movieImage;
  final String movieName;
  final String movieDetails;
  final int index;


  @override
  Widget build(BuildContext context) {
     final providerDialogue=Provider.of<DialoguesProvider>(context,listen: false);
         final provider=Provider.of<FirebaseProvider>(context,listen: false);

    final Size size=MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: size.height*0.45,
       
       decoration: BoxDecoration(
         color:  Colors.transparent,
        borderRadius: BorderRadius.circular(10),

       ),
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
         child: Column(
          children: [
            
            SizedBox(
              width: size.width,
              height: size.height*0.3,
              child: Image.network(movieImage,fit: BoxFit.fill,frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => child,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress==null) {
                  return Center(child: child);
                }else{
                  return const CircularProgressIndicator(
                      strokeWidth: 1
                    );                 
                }
              },
              ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(movieName,style:const TextStyle(color: textwhite,fontSize: 25,fontWeight: FontWeight.w900),),
              
                 IconButton(onPressed: (){
                 showDialog(context: context,
                  builder:(context) {
                    return SimpleDialog(
                      backgroundColor: textFieldBackground,
                    //  titlePadding: EdgeInsets.all(10),
                      title:const Text("do you want to delete this banner",style: TextStyle(color: textwhite,fontSize: 16,fontWeight: FontWeight.bold),),
                      children: [
                        Row(
                          children: [
                            sizedW40,
                            TextButton(onPressed: () async{
                                 providerDialogue.lottieshowing(context);
                              await provider.deleteData(context, index);
                              Navigator.pop(context);
                            }, child:const Text('Delete')),
                          
                            TextButton(onPressed: (){
                              Navigator.pop(context);
                            }, child:const Text('cancel'))
                          ],
                        )
                      ],
                    );
                  },
                 );
                 }, icon:const Icon(Icons.delete,color: Colors.red,size: 35,)),
                ],
              )
           ,Text(movieDetails,maxLines: 2,overflow: TextOverflow.ellipsis,style:const TextStyle(color: textwhite),),
        
          ],
         ),
       ),
      ),
    );
  }
}

class MovieBannerDetails{
  String moviName;
  String movieDescription;
  String imagePath;

  MovieBannerDetails({required this.moviName,required this.movieDescription,required this.imagePath});
}
