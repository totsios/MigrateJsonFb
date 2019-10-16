
const List<String> SUPPORTEDLANG=['all','en','gr'];
const jsonURLname="JSON_url";
class CachedData {
   
  static final CachedData _singleton = new CachedData._internal();

  factory CachedData() {
    return _singleton;
  }

  CachedData._internal();
  
  String _jsonurl ;
  String get jsonUrl => _jsonurl;

  set writeUrl(String url)=>_jsonurl=url;

  // saveCacheURL (String url) async{
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(jsonURLname, url);
  //   _jsonurl=url;
  // }

  // Future <String> readCachedURL() async {
    
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _jsonurl= prefs.getString(jsonURLname) ?? "";
  //   return _jsonurl;
  // }
}