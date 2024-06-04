import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:segno/login/register_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../style/style.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body:  const LoginForm(),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool saving = false;

  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: saving,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.mainColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: AppTheme.textTheme.labelLarge,
                      fixedSize: const Size(150, 50),
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          saving = true;
                        });
                        final currentUser =
                        await _authentication.signInWithEmailAndPassword(
                            email: email, password: password);
                        if (currentUser.user != null) {
                          _formKey.currentState!.reset();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showErrorSnackBar('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showErrorSnackBar(
                              'Wrong password provided for that user.');
                        }
                      } catch (e) {
                        showErrorSnackBar('Failed to login. Please try again.');
                      } finally {
                        setState(() {
                          saving = false;
                        });
                      }
                    },
                    child: const Text('확인')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text('회원이 아니시면'),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        child: const Text('이메일을 등록하세요'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}

