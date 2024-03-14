import 'dart:developer';

import 'package:appadmin/view/filimadding/searchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/apicallsProvider/api_get_function.dart';
import '../../controller/provider/apicallsProvider/commonapicallprovider.dart';
import '../../controller/provider/dialogues/showdialogue.dart';
import '../../core/colors.dart';
import '../../core/sizedBox.dart';

class FilimAdding extends StatelessWidget {
  const FilimAdding({super.key});

  @override
  Widget build(BuildContext context) {
   // final provider = Provider.of<ApiGetMoviesProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<ApicallFunction>(
          builder: (context,value,child) {
            return Column(
              children: [
                sizedH20,
                const Text(
                  'Movie List',
                  style: TextStyle(
                      color: textwhite, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                sizedH20,
                Consumer<ApiGetMoviesProvider>(
                  builder: (context,value,child) {
                    return Expanded(
                      child: ListView.separated(
                        itemCount: value.movieList.length,
                        separatorBuilder: (context, index) =>
                            const Divider(color: textFieldBackground),
                        itemBuilder: (context, index) {
                          return ListMovies(index: index);
                        },
                      ),
                    );
                  }
                ),
                Container(
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color:buttonColor,
                       // border: Border.all(color: textwhite),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchPage(),
                              ));
                        },
                        child:const Text(
                          'Add Movies',
                          style: TextStyle(color: textwhite),
                        ))),
                        sizedH10
              ],
            );
          }
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ListMovies extends StatelessWidget {
  ListMovies({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApiGetMoviesProvider>(context, listen: false);
    log('ramees${provider.movieList[index].movieId}');
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ApiGetMoviesProvider>(
          builder: (context,data,child) {
            return Container(
              height: size.height * 0.2,
              decoration:
                  BoxDecoration(border: Border.all(color: textwhite.withOpacity(0.2), width: 1),
                  // color: textwhite,
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 1,
                  //     color: Colors.black,
                  //     offset: Offset(0.2, 0.2),
                      
                  //   )
                  // ]
                   ),
                  
                  
              child: Row(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               //  sizedW10,
                 // Text('${index+1}.',style: const TextStyle(color: textwhite),),
                 // sizedW10,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.2,
                      width: size.width * 0.2,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      // ignore: prefer_interpolation_to_compose_strings
                      child: Image.network(
                        // ignore: prefer_interpolation_to_compose_strings
                        'https://www.themoviedb.org/t/p/w300_and_h450_bestv2' +
                            data.movieList[index].image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  sizedW20,
                   Column(
                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(
                          width: size.width*0.6,
                          child: Text(
                          '${data.movieList[index].originalTitle}',maxLines: 1,overflow:TextOverflow.ellipsis ,
                          style:const TextStyle(color: textwhite,fontWeight: FontWeight.bold,fontSize: 20),
                                              ),
                        ),
                        sizedH10,
                        SizedBox(
                          width: size.width*0.5,
                          child: Text(
                                              'MovieId:''${data.movieList[index].movieId},',maxLines: 1,overflow:TextOverflow.ellipsis ,
                          style:const TextStyle(color: textwhite,fontWeight: FontWeight.bold,),
                                              ),
                        ),
                    
                      
                      SizedBox(
                        child: Text(
                          'Language: ${ data.movieList[index].language}',maxLines: 1,overflow:TextOverflow.ellipsis ,
                          style:const TextStyle(color: textwhite,fontWeight: FontWeight.bold),
                        ),
                      ),
                       Text(
                        '${'ReleaseDate:'} ${data.movieList[index].releaseDate}'.substring(0,23),maxLines: 1,overflow:TextOverflow.ellipsis ,
                        style:const TextStyle(color: textwhite,fontWeight:FontWeight.bold ),
                      ),
                       sizedH20,
                       SizedBox(
                    width: size.width*0.2,
                    height: size.height*0.04,
                    child:  ElevatedButton( 
                          
                          onPressed: () async{
                          await  Provider.of<DialoguesProvider>(context,listen: false).deletionDialogue(context, index);
                          },
                        style: ElevatedButton.styleFrom(
                        padding:const EdgeInsets.all(0),
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                          )
                        ), child:const Text('Delete',style: TextStyle(color:textwhite,fontSize: 9),),
                        )
                     
                  ),
                    ],
                  ),
                 
                 
                 
                ],
              ),
            );
          }
        ));
  }
}
