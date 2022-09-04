import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Function() onPressed;

  const StandardButton({
    Key? key,
    required this.text,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: icon == null
          ? FloatingActionButton.extended(
        elevation: 2,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              onPressed: () {
                onPressed();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
            )
          : FloatingActionButton.extended(
        elevation: 2,
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              onPressed: () {
                onPressed();
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                text,
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(icon),
            ),
    );
  }
}
