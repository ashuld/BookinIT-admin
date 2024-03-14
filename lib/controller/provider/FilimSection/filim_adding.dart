

import 'dart:convert';
import 'dart:developer';
import 'package:appadmin/controller/provider/loginpage/loginPageProvider.dart';
import 'package:appadmin/core/secureStorage/storage_function.dart';
import 'package:appadmin/model/filimAdding/filimresp.dart';
import 'package:appadmin/serverSide/apiConfiguration.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../model/filimposting/filim_posting.dart';


class FilimAddingPrvider extends ChangeNotifier{
  
     List<SearchResult>list=[];
    bool isLoading=true;
   
//============================================
//filim searching from here title only take  ////
//============================================


 Future<List<SearchResult>> filimGetting(String filimTitle, BuildContext context) async {
  var storage = await storageRead(Provider.of<LoginProvider>(context, listen: false).secureStorage);
  String payload = filimTitle;
  // searchResultsList.clear();
  final movieUrl = "${ApiConfiguration.baseUrlFilim}/search/movie?api_key=${ApiConfiguration.apiKey}&query=$payload";
  
  log(storage);
  try {
    final response = await http.get(
      Uri.parse(movieUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $storage',
      },
   );
    log(response.body);
    log("${response.statusCode}");

    if (response.statusCode == 200) {
      List<SearchResult>searchResultsList=[];
      Map<String, dynamic> values =await jsonDecode(response.body) as Map<String, dynamic>;
      log("rames $values");
// (values['results'] as List).map((e) => SearchResult.fromJson(e)).toList();
     SearchResp searchResp=SearchResp.fromJson(values);
     for (SearchResult element in searchResp.data) {
     
       searchResultsList.add(element);
     }
  //  searchResultsList =(values["results"] as List).map((e) =>SearchResult.fromJson(e)).toList();
      
      notifyListeners();
      log('value indo$searchResultsList');
      
      return searchResultsList;
    } else {
      log("Something went wrong");
      return [];
    }
  } catch (e) {
    log('kollaam$e');
    return [];
  }
}
//************************************************** */
//search displaying///
//================================================== */

  List<SearchResult>displaying(String filimName,List<SearchResult>array){
   
list.clear();
  log("arrayile data $array");
 for (var element  in array ) {
  log("data of element$element");
    
     list.add(element);
 notifyListeners();
    
    
  
 }
    log("listile data $list");
return list;
}
//**************************//




//============================
//after search result posting
//===========================

 Future filimPost(List<MovieDetails> movieDetails,BuildContext context)  async{

  var storage=await storageRead(Provider.of<LoginProvider>(context,listen: false).secureStorage);
 //dynamic header=
     Map<String,dynamic> payload={
      "movieDetails":{
        "id":movieDetails[0].id,
        "title":movieDetails[0].title,
        "original_language":movieDetails[0].originalLanguage,
        "release_date":movieDetails[0].releaseDate,
        "poster_path":movieDetails[0].posterPath,
       },
     };


 try {
   final response=await http.post(Uri.parse(ApiConfiguration.baseUrl+ApiConfiguration.addMovies),
 headers: { 'Content-Type': 'application/json',
      'Accept': 'application/json', 
      'Authorization': 'Bearer $storage',
    },
 body: jsonEncode(payload),
 encoding:Encoding.getByName('utf-8'), 
 );
 log(response.body);
 log('${response.statusCode}');

   if (response.statusCode==200) {
  Map <dynamic,dynamic> decoded=jsonDecode(response.body);
   isLoading=false;
  notifyListeners();
  return decoded;
   }else{
    log("api authintication somthing wrong");
   }
 
 } catch (e) {
   log(e.toString());
 }
}
  

}