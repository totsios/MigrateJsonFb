import 'package:firebaseex/pages/aromaAttrPage.dart';
import 'package:firebaseex/utils/widgetutils.dart';
import 'package:flutter/material.dart';
import 'package:firebaseex/utils/prefers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  CachedData cachedData = CachedData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              NavigatorButton("/masterPage", "Master Data File"),
              NavigatorButton("/storeCatPage", "Store Categories"),

              NavigatorButton("/aromataPage", "Aromas"),
              //
              NavigatorButton(routeAromaAttr, aromaAttrTitle),

              NavigatorButton(
                "/attrNamesPage",
                "Attributes titles",
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200,
                  child: Center(
                    child: TextField(
                      controller: controller,
                      onSubmitted: _changeURL,
                      decoration: InputDecoration(
                        hintText: 'Enter a url for JSON...',
                        labelText: 'JSON url',
                        labelStyle: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _changeURL(String value) async {
    cachedData.writeUrl = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('JSONurl', value);
  }

  @override
  void initState() {
    super.initState();
    _getCached();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<Null> _getCached() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cachedData.writeUrl = prefs.getString('JSONurl');
    setState(() {
      controller.text = cachedData.jsonUrl;
    });
  }
}
