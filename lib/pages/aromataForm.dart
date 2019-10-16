import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebaseex/data/aromatajsonmodel.dart';
import 'package:firebaseex/data/aromatamodel.dart';
import 'package:firebaseex/utils/prefers.dart';
import 'package:flutter/material.dart';

class AromataForm extends StatefulWidget {
  final String title;
  final AromataRecord record;
  final String documentid;
  AromataForm({Key key, this.title, this.record, this.documentid})
      : super(key: key);

  _AromataFormState createState() => _AromataFormState();
}

class _AromataFormState extends State<AromataForm> {
  final aromataFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AromataRecord record = widget.record;
    final String documentID = widget.documentid;
    print(documentID);
    List<DropdownMenuItem> langDropDown = [];
  
    for (int i = 0; i < SUPPORTEDLANG.length; i++) {
      langDropDown.add(DropdownMenuItem(
        value: SUPPORTEDLANG[i],
        child: Text(SUPPORTEDLANG[i]),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: aromataFormKey,
          child: Column(
            children: <Widget>[
              ListTile(
                  title: TextFormField(
                initialValue: record.aromaCode ?? '',
                decoration: InputDecoration(
                    labelText: 'Code',
                    errorMaxLines: 1,
                    hintText: "Aroma code"),
                validator: (value) =>
                    !((value.length > 0) && (value.length < 15))
                        ? "Code should be between 1 and 14 characters long!!!"
                        : null,
                onSaved: (value) {
                  record.aromaCode = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                initialValue: record.aromaDescr ?? '',
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) {
                  record.aromaDescr = value;
                },
              )),
              ListTile(
                  title: TextFormField(
                initialValue: record.storeCat ?? '',
                decoration: InputDecoration(labelText: 'Store Category Code'),
                onSaved: (value) {
                  record.storeCat = value;
                },
              )),
              ListTile(
                  title: DropdownButtonFormField(
                items: langDropDown,
                value: record.lang ?? '',
                decoration: InputDecoration(labelText: 'Language Code'),
                onChanged: (value) {
                  setState(() {
                    record.lang = value;
                  });
                },
                onSaved: (value) {
                  record.lang = value;
                },
              )),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            child: Text("Cancel"),
            highlightColor: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            if (this.aromataFormKey.currentState.validate()) {
              this.aromataFormKey.currentState.save();
              // ds.documentID = "AromaCode";
              print("DOCID=$documentID");
              Firestore.instance
                  .collection(tablename)
                  .document(documentID)
                  .updateData(AromataRecord.toMap(record));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
