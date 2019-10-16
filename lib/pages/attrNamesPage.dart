import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/attrnamesjsonmodel.dart';
import '../data/attrnamesmodel.dart';
import '../utils/widgetutils.dart';

class AttrNamesList extends StatefulWidget {
  final String title;
  AttrNamesList({Key key, this.title}) : super(key: key);

  _AttrNamesListState createState() => _AttrNamesListState();
}

class _AttrNamesListState extends State<AttrNamesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(context),
      bottomNavigationBar: BottomBar(
          firstCaption: "Copy from JSON",
          secondCaption: "Clear DB collection",
          firstF: _copyFromJSON,
          secondF: _emptyCollection),
    );
  }

  Widget _buildBody(BuildContext context) {
    //return _buildList(context, storeCatSnapshot);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(tablename).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> storeCatSnapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children: storeCatSnapshot
          .map((data) => _buildListItem(context, data))
          .toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = AttrNamesRecord.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.attrCode),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).buttonColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
            title: Text(record.attrCode,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(" Attribute title:${record.attrName}",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 16.0,
                )),
            trailing: Text(
              record.languageCode,
              style: TextStyle(fontSize: 22.0),
            ),
            onTap: () => print(record)),
      ),
    );
  }

  _copyFromJSON() async {
    AttrNamesJsonModel model = AttrNamesJsonModel();
    List data = [];
    String s;
    s = await model.getData();

    if (s == "Success") {
      Firestore.instance.collection(tablename).getDocuments().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.documents) {
          ds.reference.delete();
        }
      });
      data = model.data;
      print("Data records:${data.length}");
      for (int r = 0; r < data.length; r++) {
        print(data[r]);
        Firestore.instance.collection(tablename).add(data[r]);
      }
    }
  }

  void _emptyCollection() {
    Firestore.instance.collection(tablename).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents) {
        ds.reference.delete();
      }
    });
  }
}
