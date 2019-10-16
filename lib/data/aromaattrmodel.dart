import 'package:cloud_firestore/cloud_firestore.dart';

final aromaAttr = [
   
    {
      "LanguageCode": "el",
      "StoreCat": "1",
      "AromaCode": "53-2000",
      "Attr1": "Att1Descr1",
      "Attr2": "Att2Descr1",
      "Attr3": "Att3Descr1",
      "Attr4": "",
      "Attr5": "",
      "Attr6": "",
      "Attr7": "",
      "Attr8": ""
    },
    {
      "LanguageCode": "el",
      "StoreCat": "1",
      "AromaCode": "53-2000",
      "Attr1": "Att1Descr2",
      "Attr2": "Att2Descr2",
      "Attr3": "Att3Descr2",
      "Attr4": "",
      "Attr5": "",
      "Attr6": "",
      "Attr7": "",
      "Attr8": ""
    }
];


class AromaAttrRecord {
 final String storeCat;
 final String aromaCode;
 final String languageCode;
 final String attr1;
 final String attr2;
 final String attr3;
 final String attr4;
 final String attr5;
 final String attr6;
 final String attr7;
 final String attr8;
 final DocumentReference reference;

 AromaAttrRecord.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['StoreCat'] != null),
       assert(map['AromaCode'] != null),     
       assert(map['LanguageCode'] != null),
       storeCat   = map['StoreCat'],
       aromaCode  = map['AromaCode'],
       languageCode = map['LanguageCode'],
       attr1 = map['Attr1'],
       attr2 = map['Attr2'],
       attr3 = map['Attr3'],
       attr4 = map['Attr4'],
       attr5 = map['Attr5'],
       attr6 = map['Attr6'],
       attr7 = map['Attr7'],
       attr8 = map['Attr8'];


 AromaAttrRecord.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "AromaAttrRecord<Code:$aromaCode,storeCategory:$storeCat,Language:$languageCode>";
}