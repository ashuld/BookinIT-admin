import 'dart:convert';
import 'dart:developer';

import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:appadmin/model/filimAdding/filimresp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'as http;
import '../../../core/secureStorage/storage_function.dart';
import '../../../serverSide/apiConfiguration.dart';



class ApiGetMoviesProvider extends ChangeNotifier {
   List<SearchResult>movieList=[];

Future apiGet(BuildContext context)async{

  
  const baseurl = ApiConfiguration.baseUrl + ApiConfiguration.getMovies;
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final token = await storageRead(secureStorage);

  
  try {
 http.Response response=await http.get(Uri.parse(baseurl),
 headers:{
       'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
 }
 );

   
    log(response.body);
    log('${response.statusCode}');
    if (response.statusCode == 200) {
      log('azhar${response.body}');
     
      Map<String, dynamic> jsonValue = jsonDecode(response.body);
        movieList = (jsonValue["data"] as List).map((e) => SearchResult.fromJson(e)).toList();
        notifyListeners();
      // SearchResp searchResult=SearchResp.fromJson(jsonValue);
      // for (var element in searchResult.data) {
      //   movieList.add(element);
      //   notifyListeners();
      // }
         log(movieList.toString());
       
       
      // log(jsonValue.toString());
      // SearchResponse searchResponse = SearchResponse.fromJson(jsonValue);
      
      // ignore: unnecessary_null_comparison
         
        return movieList;
      } else {
        log('No movie data found');
        // ignore: use_build_context_synchronously
        getError("No movie data found", context);
        return [];
      }
    
  } catch (e) {
    log('Error occurred: ${e.toString()}');
    // ignore: use_build_context_synchronously
    getError(e.toString(), context);
    return [];
  }
}


 
}
  
