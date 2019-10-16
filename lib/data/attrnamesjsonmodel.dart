
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const tablename="AttrNames";

class AttrNamesJsonModel{
String url = 'https://api.myjson.com/bins/sjdnp';
List _data;

List get data => _data;

 Future<String> getData() async{
  var res = await http.get(Uri.encodeFull(url), headers : {"Accept":"application/json; charset=utf-8"});
  var resBody = json.decode(utf8.decode(res.bodyBytes));
  _data = resBody[tablename];
  print(_data);
  return "Success";
}
  
}