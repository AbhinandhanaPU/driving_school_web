import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final server = FirebaseFirestore.instance;
final serverAuth = FirebaseAuth.instance;
final serverStorage = FirebaseStorage.instance;
