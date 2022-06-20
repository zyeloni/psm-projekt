import 'package:crud_project_android/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'main.dart';

class SignUpWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpWdgetState();
}

class _SignUpWdgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Email"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? "Wprowadź dobry email"
                        : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Hasło"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) =>
                    password != null && password.length <= 6
                        ? "Wprowadź przynajmniej 6 znaków"
                        : null,
              ),
              const SizedBox(height: 4),
              TextFormField(
                obscureText: true,
                obscuringCharacter: "*",
                controller: repeatPasswordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: "Powtórz hasło"),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => password != passwordController.text
                    ? "Hasła się nie zgadzają"
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  icon: const Icon(
                    Icons.how_to_reg,
                    size: 32,
                  ),
                  label: const Text(
                    "Zarejestruj się",
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: signUp,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    style: const TextStyle(color: Colors.black38),
                    text: "Masz już konto ? ",
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickedSignUp,
                          text: "Zaloguj się",
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Theme.of(context).colorScheme.primary))
                    ]),
              ),
            ],
          ),
        ),
      );

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar("Konto zostało wcześniej utworzone !");
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
