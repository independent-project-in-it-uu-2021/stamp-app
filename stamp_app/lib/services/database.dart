import 'package:cloud_firestore/cloud_firestore.dart';

class DataService{ //Here we will have all the operations for the database

//collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');
}