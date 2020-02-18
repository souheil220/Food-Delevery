import 'package:firebase_auth/firebase_auth.dart';
import 'package:hello_world/services/database.dart';
import '../models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (error) {
      print('sorry '+error.toString());
      return null;
    }
  }
  //Log out 
 Future logOut() async{
   await _auth.signOut();
  }

  // register with email and password

  Future registerWithEmailAndPassword(
      String email, String password, String name, String userType) async {
    try {
      AuthResult _result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser _user = _result.user;
      
      //create a new doocument for the user with the uid
      await DatabaseService(uid: _user.uid)
          .updateUserData(name, userType, email, _user.uid);
      return _userFromFirebaseUser(_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
