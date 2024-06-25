import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/components/button.dart';
import 'package:notes_app/components/textfield.dart';
import 'package:notes_app/components/square_tile.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final emailController = TextEditingController();

  final passwordController = TextEditingController(); 
 // notesapppass
  void signUserIn() async {

    // show loading circle
    showDialog(
      context: context, 
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );
      // pop loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      // Wrong email
      if (e.code == 'user-not-found') {
        // show error to user
        wrongEmailMessage();
        
      // Wrong password
      } else if (e.code == 'wrong-password') {
        // show error to user
         wrongPasswordMessage();
      }
    }
  }

  // Wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  // Wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context, 
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenSize.height * 0.05),

                // logo
                Icon(
                  Icons.note_alt_rounded,
                  size: screenSize.width * 0.3,
                ),

                SizedBox(height: screenSize.height * 0.05),

                // welcome back, you've been missed!
                Text(
                  "Welcome back you've been missed!",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: screenSize.width * 0.04,
                  ),
                ),

                SizedBox(height: screenSize.height * 0.03),

                // username
                MyTextField(
                  controller: emailController,
                  labelText: 'Email',
                  obscureText: false,
                ),

                SizedBox(height: screenSize.height * 0.02),

                // password
                MyTextField(
                  controller: passwordController,
                  labelText: 'Password',
                  obscureText: true,
                ),

                SizedBox(height: screenSize.height * 0.02),

                // forgot password
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.025),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: screenSize.height * 0.03),

                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                SizedBox(height: screenSize.height * 0.05),

                // or continue with
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
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

                SizedBox(height: screenSize.height * 0.05),

                // google + apple sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTile(imagePath: 'lib/images/google.png'),

                    SizedBox(width: screenSize.width * 0.05),

                    // apple button
                    SquareTile(imagePath: 'lib/images/apple.png')
                  ],
                ),

                SizedBox(height: screenSize.height * 0.05),

                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No account?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
