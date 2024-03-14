// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:appadmin/controller/provider/dialogues/showdialogue.dart';
import 'package:appadmin/controller/provider/loginpage/loginPageProvider.dart';
import 'package:appadmin/model/filimposting/filim_posting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../core/secureStorage/storage_function.dart';
import '../../../serverSide/apiConfiguration.dart';
import 'api_get_function.dart';

class ApicallFunction extends ChangeNotifier {
  bool isLoaded = true;

  apiPostFunction(String baseUrl, Map<String, dynamic> payload, String token,
      BuildContext context) async {
    try {
      final response = await http.post(Uri.parse(baseUrl),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: payload,
          encoding: Encoding.getByName('utf-8'));
      if (response.statusCode == 200) {
        isLoaded = false;
        log('data kitti');
        final jsondecoded = jsonDecode(response.body);
        return jsondecoded;
      } else {
        getError("api respond not getting", context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<MovieDetails>> apiGetFunction(
      String baseUrl, BuildContext context) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      log(response.body);
      log("${response.statusCode}");
      // log(response.body.)
      if (response.statusCode == 200) {
        List<MovieDetails> results = [];
        isLoaded = false;
        log('data kitti');
        Map<String, dynamic> jsondecoded = jsonDecode(response.body);
        SearchResponse searchResponse = SearchResponse.fromJson(jsondecoded);
        results.clear();
        for (var element in searchResponse.datas) {
          results.add(element);
        }
        log(results.toString());
        notifyListeners();
        return results;
      } else {
        getError("api respond not getting", context);
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  Future deleteApicall(String movieid, int index, BuildContext context) async {
    var storage = await storageRead(
        Provider.of<LoginProvider>(context, listen: false).secureStorage);

    try {
      http.Response response = await http.post(
          Uri.parse(ApiConfiguration.baseUrl + ApiConfiguration.deleteMovie),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
            'Authorization': 'Bearer $storage',
          },
          body: jsonEncode(
            {"_id": movieid},
          )

//encoding: Encoding.getByName('UTF-8')
          );
      //final responseDatas =response.body as Map<int,dynamic>;

//  if (responseDatas["success"]=='success') {
//    log('${response.body}');
//    final<dynamic,dynamic> decoded=jsonDecode(responseDatas);
//  }
      log(response.body);
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        Provider.of<ApiGetMoviesProvider>(context, listen: false)
            .movieList
            .removeAt(index);
        notifyListeners();
      } else {
        getError("somthing problem in Api delete ", context);
      }
    } catch (e) {
      getError(e.toString(), context);
    }
  }
}
