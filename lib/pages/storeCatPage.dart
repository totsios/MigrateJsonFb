import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/storecatmodel.dart';
import '../data/storecatjsonmodel.dart';
import 'package:firebaseex/utils/widgetutils.dart';

class StoreCatList extends StatefulWidget {
  final String title;
  StoreCatList({Key key, this.title}) : super(key: key);

  _StoreCatListState createState() => _StoreCatListState();
}

class _StoreCatListState extends State<StoreCatList> {
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
    final record = StoreCatRecord.fromSnapshot(data);
    return Padding(
      key: ValueKey(record.code),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).buttonColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
            title: Text(record.description),
            trailing: Text(record.languagecode),
            onTap: () => print(record)),
      ),
    );
  }

  _copyFromJSON() async {
    StoreCatJsonModel model = StoreCatJsonModel();
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
