import 'package:flutter/material.dart';

class FAB extends StatelessWidget {
  final VoidCallback onPressed;

  const FAB({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xfff7892b),
                Color(0xfffbb448),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
