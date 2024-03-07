import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_chat/helper/dialogs.dart';
import 'package:we_chat/screens/auth/auth/components/my_button.dart';
import 'package:we_chat/screens/auth/auth/components/my_textfield.dart';
import 'package:we_chat/screens/auth/auth/login_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  Future<void> sendResetEmail(BuildContext context) async {
     Dialogs.showProgressBar(context);
    try {

      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
     
    // ignore: use_build_context_synchronously
    Dialogs.showSnackbar(context, 'Password reset link sent to ${emailController.text}');
    } catch (e) {
     
      
    // ignore: use_build_context_synchronously
    Dialogs.showSnackbar(context, 'Failed to send reset link: $e');
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
                Icons.email,
                size: 100,
              ),
              const SizedBox(height: 20),

              // Email text field
              MyTextField(
                controller: emailController,
                hintText: "Email",
              ),
              const SizedBox(height: 20),

              // Send Email button
              MyButton(
                onTap: () => sendResetEmail(context),
                label: "Send Reset Link",
              ),

              const SizedBox(height: 20),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remember Password?',
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
            ],
          ),
        ),
      ),
    );
  }
}
