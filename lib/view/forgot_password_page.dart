import 'package:curiosity_app/components/my_button.dart';
import 'package:curiosity_app/components/my_textfield.dart';
import 'package:curiosity_app/controller/sign_user_in.dart';
import 'package:curiosity_app/controller/validate.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            const Text(
              'Enter your email and we\'ll send you a password reset link ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
                validator: (value) => Validate.validateEmail(value)),
            const SizedBox(
              height: 20,
            ),
            MyButton(
                onTap: () {
                  UserSigning.passwordReset(
                      _emailController.text.trim(), context);
                },
                data: 'Reset Password')
          ],
        ),
      ),
    );
  }
}
