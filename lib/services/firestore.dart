import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stockify/services/auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stockify/services/models.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User> streamReport() {
    return AuthService().userStream.switchMap((user) {
      if (user != null) {
        var ref = _db.collection('users').doc(user.uid);
        return ref.snapshots().map((doc) => User.fromJson(doc.data()!));
      } else {
        return Stream.fromIterable([User()]);
      }
    });
  }

  Future<void> addUserCategory(String categoryName) {
    var user = AuthService().user!;
    var ref = _db.collection('users').doc(user.uid);

    var data = {
      'total': FieldValue.increment(1),
      'categories': {
        FieldValue.arrayUnion([categoryName])
      }
    };
    return ref.set(data, SetOptions(merge: true));
  }
}
