import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_database/firebase_database.dart';

class FirebaseAuthHelper {
  static User? currentUser;
  static String userId = "";
  static const String eventId = "2023";

  static DatabaseReference getDatabaseReference() {
    return FirebaseDatabase.instance
        .ref("/users")
        .child(userId)
        .child("/$eventId/")
        .child("/participants");
  }

  static final refreshTokenPromise = FirebaseAuth.instance.currentUser
      ?.getIdToken()
      .then((value) => print(value));

  static void initialize() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        currentUser = null;
        userId = "";
      } else {
        print('User is signed in!');
        currentUser = user;
        userId = user.uid;
      }
    });
  }

  static void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  static void sendToDatabase(Map<dynamic, dynamic> payload, String id) {
    final DatabaseReference ref = getDatabaseReference();
    ref.child("/$id").set(payload);
    print(payload);
  }

  static Future<dynamic> getFromDatabase(String id) async {
    print(userId);
    final DatabaseReference ref = getDatabaseReference();
    final snapshot = await ref.child("/$id").get();

    //await Future.delayed(Duration(seconds: 2));
    if (snapshot.exists) {
      Map<dynamic, dynamic> map = snapshot.value as Map<dynamic, dynamic>;

      return map;
    } else {
      throw Exception("$id finns inte i databasen");
    }
  }
}
