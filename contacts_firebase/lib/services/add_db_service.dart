import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_firebase/models/user_model.dart';

class AddDbService {
  AddDbService(this.firebaseFirestore);
  final FirebaseFirestore firebaseFirestore;

  Future<void> saveUserToDB(UserModel userModel) async {
    await firebaseFirestore
        .collection('contacts')
        .doc(userModel.userId)
        .set(userModel.toJson());
  }

  Future<void> updateUserInfo(UserModel userModel) async {
    await firebaseFirestore.collection('contacts').doc(userModel.userId).update(
      {
        'name': userModel.name ?? '',
        'phoneNumber': userModel.phoneNumber ?? 0,
      },
    );
  }

  Future<void> deleteUserFromDB(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('contacts')
        .doc(userModel.userId)
        .delete();
  }
}
