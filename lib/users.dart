import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class users {
  String name;
  String surname;
  String email;
  String number;
  String address;
  String bill;

  final String uid;

  users({this.uid});

  final CollectionReference ref = Firestore.instance.collection('users');
  final CollectionReference ref1 = Firestore.instance.collection('product');

  Future addUserData(String name, String surname, String email, String number,
      String address,String bill,var arr,bool status,int cartValue,Map<dynamic,dynamic> map) async {
    return await ref.document(uid).setData({
      'Name': name,
      'Surname': surname,
      'Email': email,
      'Number': number,
      'Address': address,
      'Bill':bill,
      'Days':arr,
      'Status':status,
      'CartValue':cartValue,
      'product':map,
    });
  }

  @override
  Future<String> currentUser() async{
    final FirebaseUser user= await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  Future addmap(Map map) async {
    return await ref1.document(uid).setData(map);
  }
}
