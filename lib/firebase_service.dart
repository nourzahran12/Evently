import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/event_model.dart';
import 'package:evently/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static CollectionReference<EventModel> getEventsCollection() =>
      FirebaseFirestore.instance
          .collection('events')
          .withConverter<EventModel>(
            fromFirestore: (snapshot, _) =>
                EventModel.fromJson(snapshot.data()!),
            toFirestore: (event, _) => event.toJson(),
          );

  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance
          .collection('users')
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromjson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  static Future<void> createEvent(EventModel event) {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    DocumentReference<EventModel> doc = eventsCollection.doc();
    event.id = doc.id;
    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    CollectionReference<EventModel> eventsCollection = getEventsCollection();
    QuerySnapshot<EventModel> querySnapshot = await eventsCollection
        .orderBy('timestamp')
        .get();
    return querySnapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  static Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserModel user = UserModel(
      id: credential.user!.uid,
      name: name,
      email: email,
      favoriteEventsIds: [],
    );

    CollectionReference<UserModel> userCollection = getUsersCollection();
    await userCollection.doc(user.id).set(user);
    return user;
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    UserCredential credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    CollectionReference<UserModel> userCollection = getUsersCollection();
    DocumentSnapshot<UserModel> docSnapshot = await userCollection
        .doc(credential.user!.uid)
        .get();
    return docSnapshot.data()!;
  }

  static Future<UserModel> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

  if (googleUser == null) {
    throw FirebaseAuthException(
      code: 'aborted',
      message: 'Google sign in aborted',
    );
  }

  final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

  final AuthCredential credential =
      GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  final UserCredential userCredential =
      await FirebaseAuth.instance
          .signInWithCredential(credential);

  final String uid = userCredential.user!.uid;

  final usersCollection = getUsersCollection();
  final docSnapshot = await usersCollection.doc(uid).get();

  if (!docSnapshot.exists) {
    final user = UserModel(
      id: uid,
      name: userCredential.user!.displayName ?? '',
      email: userCredential.user!.email ?? '',
      favoriteEventsIds: [],
    );

    await usersCollection.doc(uid).set(user);
    return user;
  }

  return docSnapshot.data()!;
}

  static Future<void> logout() => FirebaseAuth.instance.signOut();

  static Future<void> addEventToFavorites(String eventId) async {
    CollectionReference<UserModel> userCollection = getUsersCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventsIds': FieldValue.arrayUnion([eventId]),
    });
  }

  static Future<void> removeEventFromFavorites(String eventId) async {
    CollectionReference<UserModel> userCollection = getUsersCollection();
    DocumentReference<UserModel> userDoc = userCollection.doc(
      FirebaseAuth.instance.currentUser!.uid,
    );
    return userDoc.update({
      'favoriteEventsIds': FieldValue.arrayRemove([eventId]),
    });
  }
}
