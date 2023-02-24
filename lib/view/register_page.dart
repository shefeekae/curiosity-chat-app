import 'package:curiosity_app/components/my_button.dart';
import 'package:curiosity_app/components/my_textfield.dart';
import 'package:curiosity_app/components/square_tile.dart';
import 'package:curiosity_app/controller/sign_user_in.dart';
import 'package:curiosity_app/controller/sign_user_up.dart';
import 'package:curiosity_app/controller/validate.dart';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  UserSigning user = UserSigning();
  UserRegister register = UserRegister();

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
                const SizedBox(height: 28),

                //logo
                const Icon(
                  Icons.lock,
                  size: 70,
                ),

                const SizedBox(height: 5),

                //welcome back, you've been missed!

                Text(
                  'Let\'s create an account for you',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 11),

                //name textfield
                // MyTextField(
                //     controller: nameController,
                //     hintText: 'Full Name',
                //     obscureText: false,
                //     validator: (value) => Validate.validateName(value!)),

                const SizedBox(
                  height: 10,
                ),

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

                //confirm password textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                  validator: (value) {
                    return Validate.validatePassword(value);
                  },
                ),

                const SizedBox(
                  height: 25,
                ),

                //sign up button
                MyButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      register.signUserUp(
                          confirmPassword: confirmPasswordController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    }
                  },
                  data: 'Sign Up',
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
                      'Already have an account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: const Text(
                        'Login now',
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
