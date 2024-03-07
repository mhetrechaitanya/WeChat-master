import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:we_chat/helper/dialogs.dart';
import 'package:we_chat/screens/auth/auth//components/my_button.dart';
import 'package:we_chat/screens/auth/auth//components/my_textfield.dart';
import 'package:we_chat/screens/auth/auth//components/square_tile.dart';
import 'package:we_chat/screens/auth/auth//login_page.dart';

import 'package:we_chat/screens/auth/auth//components/my_passfield.dart';
import 'package:we_chat/screens/home_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  void signUpUser() async {
    Dialogs.showProgressBar(context);
    try {
      // Validate email and password
      setState(() {
        emailError = emailController.text.isEmpty
            ? 'Please enter your email'
            : !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(emailController.text)
                ? 'Please enter a valid email'
                : null;
        passwordError = passwordController.text.isEmpty
            ? 'Please enter a password'
            : passwordController.text.length < 8
                ? 'Password must be at least 8 characters long'
                : null;
        confirmPasswordError = confirmPasswordController.text.isEmpty
            ? 'Please confirm your password'
            : confirmPasswordController.text != passwordController.text
                ? 'Passwords do not match'
                : null;
      });

      // Check if there are any errors in the input fields
      if (emailError != null ||
          passwordError != null ||
          confirmPasswordError != null) {
        return;
      }

      // Sign up the user using Firebase Authentication
      // ignore: unused_local_variable
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigator.pop(context);

      // Navigate to the home screen upon successful registration    
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const HomeScreen()),
        (route) => false,
      );
    } catch (e) {
      // Handle registration errors
      String errorMessage = 'An error occurred. Please try again later.';
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'The account already exists for this email.';
            break;
          case 'weak-password':
            errorMessage = 'The password provided is too weak.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is invalid.';
            break;
          default:
            errorMessage = 'Registration failed. Please try again later.';
        }
      }

      // Show error message
      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      Dialogs.showSnackbar(context, errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              // logo (assuming same as login page)
              const Icon(
                Icons.app_registration,
                size: 100,
              ),
              const SizedBox(height: 20),

              // welcome back, you've been missed!
              Text(
                'Join Us Today!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // email textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
              ),
              if (emailError != null)
                Text(
                  emailError!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 10),

              // password textfield
              MyPassField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              if (passwordError != null)
                Text(
                  passwordError!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 10),

              // confirm password textfield
              MyPassField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              if (confirmPasswordError != null)
                Text(
                  confirmPasswordError!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 25),

              // sign up button
              // sign up button
              MyButton(
                  label: 'Sign Up',
                  onTap: () {
                    signUpUser();
                  }),
              const SizedBox(height: 30),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'images/google.png'),

                  SizedBox(width: 25),

                  // apple button
                  SquareTile(imagePath: 'images/apple.png')
                ],
              ),

              const SizedBox(height: 50),

              // already a member? sign in now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Sign In now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
