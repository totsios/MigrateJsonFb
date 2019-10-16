//Ορίζω ένα record 
import 'package:cloud_firestore/cloud_firestore.dart';

class MasterRecord {
  String id;
  String companyId;
  String companyType;
  String companyEnabled;
  String aromaId;
  String aromaDescr;
  String isActive;
  String messageDescr;
  String categoryRoot;
  
  MasterRecord.fromMap(Map<String,dynamic> map , {this.reference})
    : assert(map['ID']!= null ),
      assert(map['COMPANYID']!= null ),
      assert(map['COMPANYTYPE']!= null ),
      assert(map['AROMAID']!= null ),
      assert(map['AROMADESCR']!= null ),
     // assert(map['categoryRoot']!= null ),
      id = map['ID'],
      companyId = map['COMPANYID'],
      companyType = map['COMPANYTYPE'],
      companyEnabled = map['COMPANYENABLED'],
      aromaId = map['AROMAID'],
      aromaDescr = map['AROMADESCR'],
      isActive = map['ISACTIVE'],
      messageDescr = map['MESSAGEDESCR'],
      categoryRoot = map['CategoryRoot'];
      

  DocumentReference reference;

//fromSnapshot όταν διαβάζουμε από τύπο DocumentSnapshot ενημερώνουμε το record constructor II
//snapshot.reference είναι το κλειδί αναζήτησης της εγγραφής
  MasterRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

//μέθοδος για δημιουργία map μας βοηθά στις διαδικασίες ενημέρωσης εγγραφών
  MasterRecord({id,
   companyId,
   companyType,
   companyEnabled,
   aromaId,
   aromaDescr,
   isActive,
   messageDescr,
  categoryRoot});
//Main constructor
  @override
  String toString() => "MasterRecord<$companyType:$aromaDescr>>>$messageDescr>>$categoryRoot";
//overriden method toString.
  static Map<String, dynamic> toMap(MasterRecord rec) {
    //Map<String,dynamic> map =
    return {
    "ID": rec.id,
		"COMPANYID": rec.companyId,
		"COMPANYTYPE": rec.companyType,
		"COMPANYENABLED": rec.companyEnabled,
		"AROMAID": rec.aromaId,
		"AROMADESCR": rec.aromaDescr,
		"ISACTIVE": rec.isActive,
		"MESSAGEDESCR": rec.messageDescr,
		"CategoryRoot": rec.categoryRoot
    };
  }
}
