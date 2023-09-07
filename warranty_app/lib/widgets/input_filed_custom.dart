import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

enum InputType { email, password, confirm, name, phoneNumber }

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final TextEditingController? sp;
  final String placeHolder;
  final InputType? type;
  const InputField(
      {Key? key,
      required this.label,
      this.controller,
      this.sp,
      required this.placeHolder,
      this.type})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
              color: Color(0xFF121212),
              fontWeight: FontWeight.bold,
              fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: widget.controller,
          maxLines: 5,
          // ignore: body_might_complete_normally_nullable
          validator: (value) {
            if (value.toString().isEmpty) {
              return 'Please Enter ${widget.label}';
            }
            if (widget.type == InputType.email) {
              if (!EmailValidator.validate(value.toString())) {
                return 'Invalid email!';
              }
            }
            if (widget.type == InputType.phoneNumber) {
              // You can replace this regex with the appropriate pattern for phone numbers
              RegExp phoneRegex =
                  RegExp(r'^[0-9]{10}$'); // Assuming 10-digit phone numbers
              if (!phoneRegex.hasMatch(value.toString())) {
                return 'Invalid phone number!';
              }
            }
            if (widget.type == InputType.confirm) {
              if (value != widget.sp?.text) {
                return 'Password does not match';
              }
            }
          },
          cursorColor: const Color(0xFF121212),
          style: const TextStyle(color: Color(0xFF121212)),
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            hintStyle: const TextStyle(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xFF121212)),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: widget.type != null
                ? Icon(
                    widget.type == InputType.email
                        ? Icons.email
                        : Icons.security,
                  )
                : null,
            suffix: (widget.type != null &&
                    (widget.type == InputType.password ||
                        widget.type == InputType.confirm))
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        hidden = !hidden;
                      });
                    },
                    child:
                        Icon(!hidden ? Icons.visibility : Icons.visibility_off),
                  )
                : null,
          ),
          obscureText: hidden &&
              (widget.type == InputType.password ||
                  widget.type == InputType.confirm),
        )
      ],
    );
  }
}
