import 'dart:convert';

import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:covid_tracker/model/WorldStatesModel.dart';
import 'package:http/http.dart'as http;
class StatsServices{
  Future <WorldStatesModel> getWorldStats()async{
    final response = await http.get(Uri.parse(AppUrl.WorldStatsApi));
    if(response.statusCode==200){
     var data= jsonDecode(response.body);
     return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');

    }
  }
  Future <List<dynamic>> getCountryListApi()async{
    final response = await http.get(Uri.parse(AppUrl.CountriesList));
    if(response.statusCode==200){
      var data= jsonDecode(response.body);
      return data;
    }
    else{
      throw Exception('Error');

    }}
}