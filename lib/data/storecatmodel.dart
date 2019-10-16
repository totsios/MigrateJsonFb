import 'package:cloud_firestore/cloud_firestore.dart';

final storeCatSnapshot = [
{
      "Code": "1",
      "Description": "Εστίαση",
      "LanguageCode": "el"
    },
    {
      "Code": "2",
      "Description": "Ένδυση",
      "LanguageCode": "el"
    },
    {
      "Code": "3",
      "Description": "Γραφεία",
      "LanguageCode": "el"
    },
    {
      "Code": "4",
      "Description": "Ηλεκτρικών συσκευών",
      "LanguageCode": "el"
    },
    {
      "Code": "1",
      "Description": "Food",
      "LanguageCode": "en"
    },
    {
      "Code": "2",
      "Description": "Dress",
      "LanguageCode": "en"
    },
    {
      "Code": "3",
      "Description": "Offices",
      "LanguageCode": "en"
    },
    {
      "Code": "4",
      "Description": "Electical",
      "LanguageCode": "en"
    }
];


class StoreCatRecord {
 final String code;
 final String description;
 final String languagecode;
 final DocumentReference reference;

 StoreCatRecord.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['Code'] != null),
       assert(map['Description'] != null),
       assert(map['LanguageCode'] != null),
       code         = map['Code'],
       description  = map['Description'],
       languagecode = map['LanguageCode'];

 StoreCatRecord.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "StoreCatRecord<$code:$description>>$languagecode>";
}