import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:warranty_app/views/auth/sign_up_screen.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final _formKey = GlobalKey<FormBuilderState>();
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Hello there,\nWelcome back!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'email',
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    FormBuilderTextField(
                      name: 'password',
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.tealAccent.shade700,
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                minimumSize: MaterialStateProperty.all(
                  const Size(
                    250,
                    50,
                  ),
                ),
              ),
              child: const Text(
                "SIGN IN",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  authController.login(
                      _formKey.currentState!.fields['email']?.value,
                      _formKey.currentState!.fields['password']?.value);
                }
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "New here?  ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SignUp());
                },
                child: const Text(
                  "Sign up instead",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ])
          ],
        ),
      ))),
    );
  }
}
