import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebaseex/utils/prefers.dart';

const tablename = "Aromata";

class AromataJsonModel {
  //= 'https://api.myjson.com/bins/sjdnp';

  List _data;

  List get data => _data;

  Future<String> getData() async {
    CachedData cachedData = new CachedData();
    print(Uri.encodeFull(cachedData.jsonUrl));
    var res = await http.get(Uri.encodeFull(cachedData.jsonUrl),
        headers: {"Accept": "application/json; charset=utf-8"});
    print("Data=$res");
    //var res = await http.get(Uri.encodeFull(url), headers : {"Accept":"application/json; charset=utf-8"}); //charset is just for declaration it doesn't care if it is UTF8
    var resBody = json.decode(utf8
        .decode(res.bodyBytes)); //utf8 to support other characters than english
    _data = resBody[tablename];
    print(_data);
    return "Success";
  }
}
