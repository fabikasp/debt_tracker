import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference userDebts = Firestore.instance.collection('UserDebts');
  final String userID;

  Database(this.userID);

  Stream getDebts() {
    return userDebts.document(userID).snapshots();
  }

  Future setDebt(int id, String type, String person, double amount, String reason) async {
    return await userDebts.document(userID).setData(
        {
          id.toString(): {
            "type": type,
            "person": person,
            "amount": amount,
            "reason": reason
          }
        },
        merge: true
    );
  }

  Future deleteDebt(String key) async {
    return await userDebts.document(userID).updateData(
        {key: FieldValue.delete()}
    );
  }

  Future checkIfUserExists() async {
    return (await userDebts.document(userID).get()).exists
        ? true
        : false;
  }
}