import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String desc;
  const Description(this.desc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      desc,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(
            offset: Offset(1.0, 1.0),
            blurRadius: 5.0,
            color: Colors.black54,
          )
        ],
        fontSize: 27,
        color: Colors.white,
      ),
    );
  }
}
