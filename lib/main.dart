import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'pages/homepage.dart';
import 'pages/routepagegenarator.dart';
 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false, //Debug banner invisible
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: TextTheme(title: TextStyle( fontSize: 24, fontWeight: FontWeight.bold , color: Colors.purpleAccent.shade700),
         subtitle: TextStyle( fontSize: 22, fontWeight: FontWeight.normal , color: Colors.deepPurple.shade400),
         caption:  TextStyle( fontSize: 22, fontWeight: FontWeight.normal , color: Colors.deepPurple.shade200),
         
         button: TextStyle( fontSize: 22, fontWeight: FontWeight.normal , color: Colors.deepPurple.shade700),
        ),
// subtitle: TextTheme(subtitle: TextStyle( fontSize: 24, fontWeight: FontWeight.bold , color: Colors.deepPurple.shade700),

        buttonTheme: ButtonThemeData(minWidth: 220.0, buttonColor: Colors.deepPurple.shade100, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ),
      home: MyHomePage(title: 'Migrating JSON data to Firebase'),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      // routes: <String, WidgetBuilder> {
      //   '/storeCatPage': (BuildContext context)=>StoreCatList(key: key,title:"Store categories"),
      //   '/aromataPage': (BuildContext context)=>AromataList(key: key,title:"Aromas"),
      //   '/aromataAttrPage': (BuildContext context)=>AromaAttrList(key: key,title:"Aromas attributes"),
      //   '/attrNamesPage': (BuildContext context)=>AttrNamesList(key: key,title:"Attributes' titles"),
      // },
    );
  }
}
