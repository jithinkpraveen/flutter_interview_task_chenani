import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:task/app_config.dart';
import 'package:task/model/home_header_model.dart';

abstract class HomeRepo {
  Future getSalon();
  Future getServiceList();
}

class HomeServices implements HomeRepo {
  @override
  Future getSalon() async {
    try {
      Uri uri = Uri.parse(AppConfig.rootUrl + AppConfig.getSalon);
      http.Response response = await http.get(uri, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + AppConfig.token,
        'accept': 'application/json'
      });
      HomeHeaderModel homeheader =
          HomeHeaderModel.fromJson(jsonDecode(response.body));
      return homeheader;
    } catch (e) {
      return false;
    }
  }

  @override
  Future getServiceList() async {
    Uri uri = Uri.parse(AppConfig.rootUrl + AppConfig.getServiceList);
    var data = await http.post(uri, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + AppConfig.token,
      'accept': 'application/json'
    });
    print(data.statusCode);
    log(jsonDecode(data.body).toString());
    return data;
  }
}
