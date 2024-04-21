import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final VoidCallback? onAddClick;

  const EmptyWidget({super.key, this.onAddClick});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('No todos yet. Click '),
        TextButton(
          onPressed: onAddClick,
          child: const Text('here'),
        ),
        const Text(' to add one.'),
      ],
    );
  }
}
