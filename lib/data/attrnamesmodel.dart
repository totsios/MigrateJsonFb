import 'package:cloud_firestore/cloud_firestore.dart';

final attrNames = [
    {
      "AttrCode": "1",
      "AttrName": "Χαρακτηριστικό 1",
      "LanguageCode": "el"
    },
    {
      "AttrCode": "2",
      "AttrName": "Χαρακτηριστικό 2",
      "LanguageCode": "el"
    }
];


class AttrNamesRecord {
 final String attrCode;
 final String attrName;
 final String languageCode;
  
 final DocumentReference reference;

 AttrNamesRecord.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['AttrCode'] != null),
       assert(map['AttrName'] != null),     
       assert(map['LanguageCode'] != null),
       attrCode   = map['AttrCode'],
       attrName  = map['AttrName'],
       languageCode = map['LanguageCode'];
       


 AttrNamesRecord.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "AttrNamesRecord<Code:$attrCode,Attribute title:$attrName,Language:$languageCode>";
}