import 'dart:convert';

import 'package:covid_19_tracker_app/Model/WorldStatesModel.dart';
import 'package:http/http.dart' as http;

import 'Utilities/app_url.dart';

class StatesServices {
   Future<WorldStatesModel> fetchWorldStatesRecord() async {
    final response = await http.get(Uri.parse(AppUrl.worldStatesApi));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStatesModel.fromJson(data);
    } else {
      throw Exception("Failed to load data");
    }
  }
  Future<List<dynamic>> countriesListApi() async {
     var data;
    final response = await http.get(Uri.parse(AppUrl.countriesList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Failed to load data");
    }
  }
}