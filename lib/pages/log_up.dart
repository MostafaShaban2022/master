import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_14/pages/home.dart';
import 'package:flutter_application_14/widgets/custom_button.dart';
import 'package:flutter_application_14/widgets/custom_text_form_field.dart';
import 'package:http/http.dart';
import 'dart:convert';

class LogUp extends StatefulWidget {
  const LogUp({super.key});

  @override
  State<LogUp> createState() => _LogUpState();
}

class _LogUpState extends State<LogUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login(String email, password) async {
    try {
      final Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('your account created');
        } else {
          if (kDebugMode) {
            print('failed');
          }
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Log Up',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomTextFormField(
                id: 1,
                name: 'Email',
                hintText: 'your e-mail',
                controller: emailController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextFormField(
                id: 2,
                name: 'Password',
                hintText: 'password',
                controller: passwordController,
                keyboardType: TextInputType.phone,
              ),
              Container(
                margin: const EdgeInsets.only(top: 55),
                height: 60,
                width: 175,
                child: TextButton(
                  onPressed: () {
                    login(
                      emailController.text.toString(),
                      passwordController.text.toString(),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
