import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutor_finder/Services/global_variables.dart';

class Persistent {
  static List<String> tuitionCategoryList = [
    'Kindergarten',
    'Primary',
    'High School',
    'Higher Secondary',
    'SSC Preparation',
    'HSC Preparation',
    'Admission Preparation',
    'Math Olympiad',
    'Programming',
    'BCS Preparation',
    'Job Preparation',
    'Engineering Preparation',
    'Medical Admission Preparation',
    'University Preparation',
  ];

  void getMyData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    name = userDoc.get('name');
    userImage = userDoc.get('userImage');
    location = userDoc.get('location');
  }
}
