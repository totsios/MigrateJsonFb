import 'package:firebaseex/data/aromatamodel.dart';
import 'package:flutter/material.dart';
import 'aromataForm.dart';
import 'homepage.dart';
import 'aromaAttrPage.dart';
import 'aromataPage.dart';
import 'attrNamesPage.dart';
import 'storeCatPage.dart';
import 'masterPage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
print(settings.name);
print(settings.arguments);
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
        break;
      case '/storeCatPage':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => StoreCatList(
                  title: args,
                ),
          );
        }
        return _errorRoute();
        break;
      case '/masterPage':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => MasterList(
                  title: args,
                ),
          );
        }
        return _errorRoute();
        break;        
      case '/aromataPage':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AromataList(
                  title: args,
                ),
          );
        }
        return _errorRoute();
        break;
        case '/aromataForm':
        // Validation of correct data type
        Map<String,dynamic> e  =args;
         if ((e['title'] is String) && (e['record'] is AromataRecord) ) {
         //if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AromataForm(
                  title: e['title'],
                  record: e['record'],
                  documentid: e['documentid'],
                ),
          );
        }
        return _errorRoute();
        break;

      case '/attrNamesPage':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AttrNamesList(
                  title: args,
                ),
          );
        }
        return _errorRoute();
        break;

      case routeAromaAttr:
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AromaAttrList(
                  title: args,
                ),
          );
        }
        return _errorRoute();
        break;
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Page not found!!'),
        ),
      );
    });
  }
}
