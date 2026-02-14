import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CommonTextField extends StatefulWidget {
  final String titleText;
  final IconData icon;
  final String hintText;
  final bool isPasswordField;
  final TextInputType? textInputType;
  final TextEditingController controller;
  const CommonTextField({
    super.key,
    required this.titleText,
    required this.icon,
    this.textInputType,
    required this.hintText,
    this.isPasswordField = false,
    required this.controller,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late bool showPassword;
  @override
  void initState() {
    showPassword = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleText,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Gap(10),
        TextFormField(
          controller: widget.controller,
          obscureText: showPassword,
          keyboardType: widget.textInputType,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(widget.icon, color: Colors.grey.shade500),
            fillColor: Colors.grey.shade200,
            filled: true,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey.shade500,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
