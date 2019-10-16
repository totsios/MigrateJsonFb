
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

const tablename="MasterFile";

class MasterJsonModel{
//String url = 'https://api.myjson.com/bins/sjdnp';
List _data;

List get data => _data;

 Future<String> getJsonFromAsset(String assetPath) async{
  var res = await rootBundle.loadString(assetPath);
  print(res);
return res;
  
}
  
}