import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        splashColor: Colors.green.withOpacity(0.3),
        child: Ink(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.amber.shade400,
                Colors.amber.shade300,
                Colors.amber.shade200,
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              buttonName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
