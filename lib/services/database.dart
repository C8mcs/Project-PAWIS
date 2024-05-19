import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pawis_application/models/userModel.dart';
import 'package:pawis_application/models/userPointsModel.dart';

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

  // user list from snapshot
  List<UserDetailsModel> _userDetailsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserDetailsModel(
          fullname: doc.get('fullname') ?? '',
          address: doc.get('address') ?? '',
          phoneNumber: doc.get('phoneNumber') ?? '');
    }).toList();
  }

  // user data from snapshots
  UserDetailsModel _userDetailsFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetailsModel(
        uid: uid,
        fullname: snapshot.get('fullname'),
        address: snapshot.get('address'),
        phoneNumber: snapshot.get('phoneNumber'));
  }

  // get user's stream
  Stream<List<UserDetailsModel>> get userDetails {
    return userDetailsCollection.snapshots().map(_userDetailsListFromSnapshot);
  }

  // get user doc stream
  Stream<UserDetailsModel> get userData {
    return userDetailsCollection
        .doc(uid)
        .snapshots()
        .map(_userDetailsFromSnapshot);
  }

  // ----------------------------------------------------

  // user list from snapshot
  List<UserPointsModel> _userPointsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return UserPointsModel(
        points: doc.get('points') ?? '',
      );
    }).toList();
  }

  // user data from snapshots
  UserPointsModel _userPointsFromSnapshot(DocumentSnapshot snapshot) {
    return UserPointsModel(
      uid: uid,
      points: snapshot.get('points') ??
          '0', // Provide a default value of '0' if 'points' is null
    );
  }

  // get user's stream
  Stream<List<UserPointsModel>> get userPointsDetails {
    return userPointsCollection.snapshots().map(_userPointsListFromSnapshot);
  }

  // get user doc stream
  Stream<UserPointsModel> get userPointsData {
    return userPointsCollection
        .doc(uid)
        .snapshots()
        .map(_userPointsFromSnapshot);
  }
}
