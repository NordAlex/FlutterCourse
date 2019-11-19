import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {

  const CircleButton(
      this._icon, this._backgroundColor, this._iconColor, this._onTap);
  final IconData _icon;
  final Color _backgroundColor;
  final Color _iconColor;
  final Function _onTap;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: _onTap,
      child: Icon(
        _icon,
        color: _iconColor,
        size: 35.0,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: _backgroundColor,
      padding: const EdgeInsets.all(15.0),
    );
  }
}
