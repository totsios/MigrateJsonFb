import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/aromaattrjsonmodel.dart';
import '../data/aromaattrmodel.dart';
import '../utils/widgetutils.dart';


const routeAromaAttr='/aromataAttrPage';
const aromaAttrTitle="Aromas Attributes";


class AromaAttrList extends StatefulWidget {
  final String title;
  AromaAttrList({Key key, this.title}) : super(key: key);

  _AromaAttrListState createState() => _AromaAttrListState();
}

class _AromaAttrListState extends State<AromaAttrList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(context),
      //bottomNavigationBar:
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
    final record = AromaAttrRecord.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.aromaCode),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).buttonColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
            title: Text(record.aromaCode,
                style: TextStyle(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            subtitle: Text(
                " Store Category:${record.storeCat},Attr1:${record.attr1},Attr2:${record.attr2},Attr3:${record.attr3},Attr4:${record.attr4},Attr5:${record.attr5}",
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
    AromaAttrJsonModel model = AromaAttrJsonModel();
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
