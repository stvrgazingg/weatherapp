import 'package:flutter/material.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Cancel', style: TextStyle(color: Colors.red)),
      onPressed: () {
        Navigator.pop(context);
        //   Navigator.pop(context);
      },
    );
  }
}
