import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_database/firebase_database.dart';

final User currentUser = FirebaseAuth.instance.currentUser!;
final String userId = currentUser.uid;
const String eventId = "2023";

final DatabaseReference ref = FirebaseDatabase.instance
    .ref("/users")
    .child(userId)
    .child("/$eventId/")
    .child("/participants");

final refreshTokenPromise = FirebaseAuth.instance.currentUser
    ?.getIdToken()
    .then((value) => print(value));

void signUserOut() {
  FirebaseAuth.instance.signOut();
}

void sendToDatabase(Map<dynamic, dynamic> payload, String id) {
  ref.child("/$id").set(payload);
  print(payload);
}

Future getFromDatabase(String id) async {
  final snapshot = await ref.child("/$id").get();

  //await Future.delayed(Duration(seconds: 2));
  if (snapshot.exists) {
    Map<dynamic, dynamic> map = snapshot.value as Map;

    return map;
  } else {
    throw Exception("$id not in database");
  }
}
// Map<String, dynamic> datar