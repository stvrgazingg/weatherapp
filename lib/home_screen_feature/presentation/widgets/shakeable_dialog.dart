import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';

import '../main.dart';
import 'city_alert_dialog.dart';

class ShakeableDialog extends StatefulWidget {
  final Duration duration; // how fast to shake
  final double distance; // how far to shake

  const ShakeableDialog({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.distance = 24.0,
  }) : super(key: key);

  @override
  ShakeableDialogState createState() => ShakeableDialogState();
}

class ShakeableDialogState extends State<ShakeableDialog>
    with SingleTickerProviderStateMixin {
  var defHintText = ' Enter your city';
  Color defTextColor = Colors.grey;
  FontWeight defWeight = FontWeight.normal;
  bool error = false;

  @override
  Widget build(BuildContext context) {
    return ShakeMe(
          key: shakeKey,
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: const AlertDialogCity(),
        );
  }
}
