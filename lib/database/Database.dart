import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final CollectionReference userDebts = Firestore.instance.collection('UserDebts');
  final String userID;

  Database(this.userID);

  Stream getDebts() {
    return this.userDebts.document(this.userID).snapshots();
  }

  Future setDebt(int id, String type, String person, double amount, String reason) async {
    return await this.userDebts.document(this.userID).setData(
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
    return await this.userDebts.document(this.userID).updateData(
        {key: FieldValue.delete()}
    );
  }

  Future checkIfUserExists() async {
    return (await this.userDebts.document(this.userID).get()).exists
        ? true
        : false;
  }
}