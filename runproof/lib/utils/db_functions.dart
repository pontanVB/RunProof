import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_database/firebase_database.dart';

final User currentUser = FirebaseAuth.instance.currentUser!;
final String userId = currentUser.uid;
final DatabaseReference ref = FirebaseDatabase.instance
    .ref("/users")
    .child(userId)
    .child("/participants");
final refreshTokenPromise = FirebaseAuth.instance.currentUser
    ?.getIdToken()
    .then((value) => print(value));

void sendToDatabase() {
  Map<String, dynamic> data = {"name": "carr", "age": 18, "time": 10};
  ref.set(data);
  print(currentUser);
}

void getFromDatabase() {}
// Map<String, dynamic> datar