// ignore_for_file: unused_import
import 'package:chatapp/helper/helper_function.dart';
import 'package:chatapp/service/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // login
  Future loginWithUserNameandPassword(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        return true;
      }
      else {
        return "Login failed, please check your credentials.";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    catch (e) {
      return "An error occurred. Please try again later.";
    }
  }

  // register
  Future registerUserWithEmailandPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      // ignore: unnecessary_null_comparison
      if (user != null) {
        // call our database service to update the user data.
        await DatabaseService(uid: user.uid).savingUserData(fullName, email);
        return true;
      }
       else {
        return "Registration failed. Please try again later.";
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    catch (e) {
      return "An error occurred. Please try again later.";
    }
   
  }

  // signout
  Future<void> signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSF("");
      await HelperFunctions.saveUserNameSF("");
      await firebaseAuth.signOut();
    } catch (e) {
      // ignore: avoid_print
      print("Sign out error: $e");
    }
  } 
}