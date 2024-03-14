

import 'dart:convert';
import 'dart:developer';
import 'package:appadmin/model/filimposting/filim_posting.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;

import '../../controller/provider/apicallsProvider/commonapicallprovider.dart';



class ApiServices{


searchGetting(BuildContext context,String payload) async{

  List<MovieDetails>responseList=[];
  

final provider= Provider.of<ApicallFunction>(context,listen: false);
//final token =await storageRead(Provider.of<LoginProvider>(context,listen: false).secureStorage);
//log(token);


String baseurl="https://api.themoviedb.org/3/search/movie?api_key=a16115323f4b6863e6772960d6d13c22&query=$payload";


// ignore: use_build_context_synchronously
responseList=await provider.apiGetFunction(baseurl,context);
log(responseList.toString());



return responseList;




}


  Future<http.Response> postAPIWithToken(
      String url, String token, dynamic body) async {
        const baseUrl='https://bookmyscreen.onrender.com/admin';
    final response = await http.post(Uri.parse(baseUrl + url),
        headers: {
          'Content-type': 'application/json;charset=utf-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(body),
        encoding: Encoding.getByName('utf-8'));
    return response;
  }


  Future<http.Response> getAPIWithToken(String url, String token) async {
            const baseUrl='https://bookmyscreen.onrender.com/admin/';

    final response = await http.get(Uri.parse(baseUrl + url), headers: {
      'Content-type': 'application/json;charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    return response;
  }


}