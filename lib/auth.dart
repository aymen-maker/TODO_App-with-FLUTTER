import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/Task.dart';
import 'user.dart';

ItemsRepository repTasks;
ItemsRepositoryTot repHist;

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      var userUpdateInfo = UserUpdateInfo();

      FirebaseUser user = result.user;
      userUpdateInfo.displayName = "anon";
      await user.updateProfile(userUpdateInfo);
      return _userFromFirebaseUser(user);
    }

    catch (e) {
      print (e.toString());
      return null;
    }
  }

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User (uid: user.uid,displayName: user.displayName, email: user.email): null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Future<FirebaseUser> currentUser(){
    return _auth.currentUser();
  }

  Future signInWithEmailAndPassword (String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);

    }
    catch(e) {
      print(e.toString());
      return null;

    }
  }

  Future registerWithEmailAndPassword (String email, String password,String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var userUpdateInfo = UserUpdateInfo();

      FirebaseUser user = result.user;
      userUpdateInfo.displayName = username;
      await user.updateProfile(userUpdateInfo);


      /*await DatabaseService(uid: user.uid).updateUserData(repTasks,repHist);
      return _userFromFirebaseUser(user);*/

    }
    catch(e) {
      print(e.toString());
      return null;
      
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    }

    catch (e) {
      print(e.toString());
      return null;
    }
  }


}