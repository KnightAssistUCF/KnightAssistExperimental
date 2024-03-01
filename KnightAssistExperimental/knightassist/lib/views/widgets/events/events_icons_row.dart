import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../routes/app_router.dart';

class EventsIconsRow extends HookWidget {
  const EventsIconsRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded),
            padding: const EdgeInsets.all(0),
            onPressed: () => AppRouter.pop(),
          )
        ],
      ),
    );
  }
}
