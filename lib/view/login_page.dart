import 'package:curiosity_app/components/my_button.dart';
import 'package:curiosity_app/components/my_textfield.dart';
import 'package:curiosity_app/components/square_tile.dart';
import 'package:curiosity_app/controller/sign_user_in.dart';
import 'package:curiosity_app/controller/validate.dart';
import 'package:curiosity_app/services/auth_service.dart';

import 'package:flutter/material.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  final Function()? onTap;

  LoginPage({super.key, required this.onTap});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UserSigning user = UserSigning();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),

                //logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                //welcome back, you've been missed!

                Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),

                //email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  validator: (value) => Validate.validateEmail(value),
                ),

                const SizedBox(height: 10),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                  validator: (value) {
                    return Validate.validatePassword(value);
                  },
                ),

                const SizedBox(height: 10),

                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ForgotPasswordPage();
                            },
                          ));
                        },
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),
                //sign in button
                MyButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      user.signUserIn(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    }
                  },
                  data: 'Sign In',
                ),
                const SizedBox(
                  height: 25,
                )
                //or continue with
                ,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      )),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ))
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //google + apple sign in button

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.png',
                      scale: 30,
                    ),
                    const SizedBox(width: 10),
                    //apple button
                    SquareTile(
                      onTap: () {},
                      imagePath: 'lib/images/apple.png',
                      scale: 15,
                    )
                  ],
                ),

                const SizedBox(height: 30),

                //not a member? register now

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
