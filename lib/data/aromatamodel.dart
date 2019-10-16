import 'package:cloud_firestore/cloud_firestore.dart';
//Τυπικά η εγγραφή json θα είχε την ακόλουθη δομή...
final aromata = [
  {
    "StoreCat": "1",
    "AromaCode": "53-2000",
    "AromaDescr": "Mango Delight",
    "Lang": "all"
  },
  {
    "StoreCat": "1",
    "AromaCode": "53-2020",
    "AromaDescr": "Bitter Almond",
    "Lang": "all"
  }
];

//Ορίζω ένα record 
class AromataRecord {
  String storeCat;
  String aromaCode;
  String aromaDescr;
  String lang;
  DocumentReference reference;
//fromMap όταν διαβάζουμε από τύπο Map ενημερώνουμε το record constructor I
  AromataRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['StoreCat'] != null),
        assert(map['AromaCode'] != null),
        assert(map['AromaDescr'] != null),
        assert(map['Lang'] != null),
        storeCat = map['StoreCat'],
        aromaCode = map['AromaCode'],
        aromaDescr = map['AromaDescr'],
        lang = map['Lang'];
//fromSnapshot όταν διαβάζουμε από τύπο DocumentSnapshot ενημερώνουμε το record constructor II
//snapshot.reference είναι το κλειδί αναζήτησης της εγγραφής
  AromataRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

//μέθοδος για δημιουργία map μας βοηθά στις διαδικασίες ενημέρωσης εγγραφών
  static Map<String, dynamic> toMap(AromataRecord rec) {
    //Map<String,dynamic> map =
    return {
      "AromaCode": rec.aromaCode,
      "AromaDescr": rec.aromaDescr,
      "StoreCat": rec.storeCat,
      "Lang": rec.lang
    };
  }
//Main constructor
  AromataRecord({aromaCode, storeCat, aromaDesr, lang});
//overriden method toString.
  @override
  String toString() => "AromataRecord<$aromaCode:$aromaDescr>>$lang>";
}
