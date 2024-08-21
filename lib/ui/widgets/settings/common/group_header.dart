import 'package:flutter/material.dart';

class GroupHeader extends StatelessWidget {
  const GroupHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      color: Colors.transparent,
      elevation: 0,
      child: Text(
        name,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
        ),
      ),
    );
  }
}
