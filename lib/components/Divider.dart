import 'package:flutter/material.dart';

/// Custom Divider widget
class CD extends StatelessWidget {
  const CD({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
            child: Divider(
              thickness: 1,
              height: 1,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}
