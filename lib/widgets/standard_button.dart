import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  final String text;
  final IconData? icon;

  const StandardButton({
    Key? key,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: icon == null
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            )
          : FloatingActionButton.extended(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              onPressed: () {},
              label: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(Icons.add),
            ),
    );
  }
}
