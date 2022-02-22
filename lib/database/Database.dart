import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final String userID;
  Database(this.userID);

  final CollectionReference userDebts = Firestore.instance.collection('UserDebts');

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

  Stream getDebts() {
    return userDebts.document(userID).snapshots();
  }
}