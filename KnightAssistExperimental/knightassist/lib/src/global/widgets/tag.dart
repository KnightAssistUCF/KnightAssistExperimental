import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Tag extends ConsumerWidget {
  final String tag;
  Tag({required this.tag});
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Chip(
        backgroundColor: (Colors.grey[300]),
        label: Text(
          tag,
          style: const TextStyle(color: (Colors.black)),
        ),
      ),
    );
  }
}
