import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userDetailsCollection =
      FirebaseFirestore.instance.collection('userDetails');
  final CollectionReference userPointsCollection =
      FirebaseFirestore.instance.collection('userPoints');

  Future updateUserData(
      String fullname, String address, String phoneNumber) async {
    return await userDetailsCollection.doc(uid).set({
      'fullname': fullname,
      'address': address,
      'phoneNumber': phoneNumber,
    });
  }

  Future updateUserPoints(int points) async {
    return await userPointsCollection.doc(uid).set({'points': points});
  }
}
