import 'package:firebaseex/data/aromatajsonmodel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/aromatamodel.dart';
import '../data/aromatajsonmodel.dart';
import '../utils/widgetutils.dart';

class AromataList extends StatefulWidget {
  final String title;
  AromataList({Key key, this.title}) : super(key: key);

  _AromataListState createState() => _AromataListState();
}

class _AromataListState extends State<AromataList> {
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
          if (!snapshot.hasData)
            return Center(child: LinearProgressIndicator());
          return _buildList(context, snapshot.data.documents);
        });
  }

  Widget _buildList(
      BuildContext context, List<DocumentSnapshot> aromataSnapshot) {
    return ListView(
      padding: EdgeInsets.only(top: 20.0),
      children:
          aromataSnapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = AromataRecord.fromSnapshot(data); //Εδώ διαβάζουμε το πεδίο reference ID 
    return Padding(
      key: ValueKey(data.documentID),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).buttonColor),
            borderRadius: BorderRadius.circular(5.0)),
        child: ListTile(
            title: TextTitle(record.aromaDescr),
            subtitle: TextSubTitle(
                "Store Category:${record.storeCat}, Aroma Code: ${record.aromaCode}"),
            trailing: TextTrailing("Language: ${record.lang}"),
            onTap: () {
              print(data.documentID);
              print(data);
              print(record);
              Navigator.of(context).pushNamed(
                "/aromataForm",
                arguments: <String, dynamic>{
                  'title': 'Arome',
                  'record': record,
                  'documentid': data.documentID
                },
              );
            }
            //onTap: () => print(record)),
            ),
      ),
    );
  }

  _copyFromJSON() async {
    AromataJsonModel model = AromataJsonModel();
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
      print("Data records:${data.length ?? 0}");
      for (int r = 0; r < data.length ?? 0; r++) {
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
