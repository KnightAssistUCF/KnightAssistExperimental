import 'package:flutter/material.dart';

import '../../../global/widgets/custom_text.dart';
import '../../../helpers/constants/app_styles.dart';
import '../widgets/events_list/events_search_bar.dart';
import '../widgets/events_list/events_list.dart';

class EventsListScreen extends StatelessWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH20,

            // Title
            CustomText.title('Events'),

            Insets.gapH20,

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: EventsSearchBar(),
            ),

            const Expanded(
              child: EventsList(),
            )
          ],
        ),
      ),
    );
  }
}
