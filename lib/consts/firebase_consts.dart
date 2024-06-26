 import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
final FirebaseAuth authInstance = FirebaseAuth.instance;
final User? user = authInstance.currentUser;
final uid = user!.uid;