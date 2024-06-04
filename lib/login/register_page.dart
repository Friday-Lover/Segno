import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../main/start_page.dart';
import '../style/style.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Segno', style: AppTheme.textTheme.displaySmall),
        backgroundColor: AppTheme.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _authentication = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String email = '';
  bool saving = false;
  String password = '';
  String userName = '';

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
                        final newUser = await _authentication
                            .createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (newUser.user != null) {
                          _formKey.currentState!.reset();
                          if (!mounted) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                          setState(() {
                            saving = false;
                          });
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showErrorSnackBar(
                              'The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          showErrorSnackBar(
                              'The account already exists for that email.');
                        }
                      } catch (e) {
                        showErrorSnackBar(
                            'Failed to create an account. Please try again.');
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
                    const Text('이미 회원이시라면 '),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('이메일로 로그인하세요'))
                  ],
                )
              ],
            )),
      ),
    );
  }
}
