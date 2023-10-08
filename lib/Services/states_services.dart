import 'dart:convert';

import 'package:covid_app/Model/WorldStatesModel.dart';
import 'package:covid_app/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http;

class StatesServices{

  Future<WorldStatesModel> getData()async{
    final response = await http.get(Uri.parse(appUrl.worldStatesApi));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
     return WorldStatesModel.fromJson(data);
    }
    else{
      throw Exception('Error');
    }

  }
  Future<List<dynamic>> getCountriesData()async{
    final response = await http.get(Uri.parse(appUrl.countryStatesApi));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return data;
    }
    else{
      throw Exception('Error');
    }

  }
}