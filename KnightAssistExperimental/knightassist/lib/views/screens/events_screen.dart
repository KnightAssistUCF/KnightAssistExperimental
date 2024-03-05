import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../helper/extensions/context_extensions.dart';

import '../../providers/events_provider.dart';

class EventsScreen extends HookConsumerWidget {
  const EventsScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = context.screenHeight;
    final events = ref.watch(eventsFuture);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(),
    );
  }
}
