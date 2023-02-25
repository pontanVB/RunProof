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

void sendToDatabase(Map<String, dynamic> payload, String id) {
  ref.child("/$id").set(payload);
  print(payload);
}

Future getFromDatabase(String id) async {
  final snapshot = await ref.child("/$id").get();
  if (snapshot.exists) {
    Map<dynamic, dynamic> map = snapshot.value as Map;

    String responseName = map["name"];
    print("getting from api");
    print("got $responseName");
    return map;
  } else {
    print('No data available.');
  }
}
// Map<String, dynamic> datar