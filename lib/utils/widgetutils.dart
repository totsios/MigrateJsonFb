import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
//import 'package:flutter/semantics.dart';

class TextTitle extends StatelessWidget {
  final String title;
  TextTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: Theme.of(context).textTheme.title.color,
            fontSize: 22.0,
            fontWeight: FontWeight.bold));
  }
}

class TextSubTitle extends StatelessWidget {
  final String title;
  TextSubTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        color:   Theme.of(context).textTheme.subtitle.color,
        fontSize: 18.0,
      ),
    );
  }
}

class TextTrailing extends StatelessWidget {
  final String title;
  TextTrailing(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        color:  Theme.of(context).textTheme.caption.color,
        fontSize: 18.0,
      ),
    );
  }
}

class TextButtonCaption extends StatelessWidget {
  final String title;
  TextButtonCaption(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: TextStyle(
        color:  Theme.of(context).textTheme.button.color,
        fontWeight: FontWeight.w600,
       // fontSize: 18.0,
      ),
    );
  }
}


class NavigatorButton extends StatelessWidget {
  final String pagepath;
  final String caption;
  NavigatorButton(this.pagepath, this.caption);
  @override
   Widget build(BuildContext context) {
        return  Container(
                child: Center(
                  child: RaisedButton(
                    child: TextButtonCaption(caption),
                    onPressed: () {
                      Navigator.of(context).pushNamed(pagepath, arguments: caption);
                    },
                  ),
                ),
              );
  }
}

class BottomBar extends StatelessWidget {
  final Function firstF;
  final Function secondF;
  final String firstCaption;
  final String secondCaption;

  BottomBar({Key key,  @required this.firstCaption, @required this.secondCaption, 
                     @required this.firstF, @required this.secondF}): super(key: key);
  @override
   Widget build(BuildContext context) {
  return BottomAppBar(
    elevation: 10.0,
        color: Theme.of(context).primaryColor,
        child: Container(
          height: 120.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text(firstCaption),
                onPressed: firstF,
              ),
              RaisedButton(
                child: Text(secondCaption),
                onPressed: secondF,
              ),
            ],
          ),
        ),
      );
   }
}