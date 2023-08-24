// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:warranty_app/controllers/auth_controller.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
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
                        name: 'full_name',
                        decoration:
                            const InputDecoration(labelText: 'Full Name'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'phone',
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.equalLength(10),
                        ]),
                      ),
                      SizedBox(height: 10),
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
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(6),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        name: 'confirm_password',
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: Icon(
                              _formKey.currentState?.fields['confirm_password']
                                          ?.hasError ==
                                      false
                                  ? Icons.error
                                  : Icons.check,
                              color: _formKey
                                          .currentState
                                          ?.fields['confirm_password']
                                          ?.hasError ==
                                      false
                                  ? Colors.red
                                  : Colors.green),
                        ),
                        obscureText: true,
                        validator: (value) =>
                            _formKey.currentState?.fields['password']?.value !=
                                    value
                                ? 'No coincident'
                                : null,
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
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    authController.register(
                        _formKey.currentState!.fields['email']?.value,
                        _formKey.currentState!.fields['password']?.value);
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already a member? ",
                    style: TextStyle(
                      // color: Colors.grey.shade900,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Sign in",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      )),
    ));
  }
}
