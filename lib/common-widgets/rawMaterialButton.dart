import 'package:flutter/material.dart';

class RawMaterialButtonWidget extends StatelessWidget {
  const RawMaterialButtonWidget(this.icon, this.onPressed);
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: 
    RawMaterialButton(
      child: Icon(icon, color: Colors.white),
      onPressed: onPressed,
      shape: CircleBorder(),
        fillColor: Theme.of(context).buttonColor,
      ),
    );
  }
}