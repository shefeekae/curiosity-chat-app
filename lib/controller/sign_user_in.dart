import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserSigning {
  signUserIn(
      {required email,
      required password,
      required BuildContext context}) async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //try signIn
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //Pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //Pop the loading circle
      Navigator.pop(context);

      //Wrong Email
      if (e.code == 'user-not-found') {
        //SHOW ERROR TO USER
        return wrongEmailMessage(context);
      }

      //Wrong password
      else if (e.code == 'wrong-password') {
        //SHOW ERROR TO USER
        return wrongPasswordMessage(context);
      }
    }
  }

  signUserOut() {
    FirebaseAuth.instance.signOut();
  }

//Wrong Email message popup
  static wrongEmailMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

//Wrong Password message popup
  static wrongPasswordMessage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  static Future passwordReset(email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
              content: Text('Password reset link sent! Check your Email'));
        },
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Text(
            e.message.toString(),
          ));
        },
      );
    }
  }
}
