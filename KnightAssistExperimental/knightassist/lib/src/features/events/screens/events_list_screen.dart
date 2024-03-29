import 'package:flutter/material.dart';

import '../../../config/routing/routing.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Back Icon
                  InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      size: 32,
                      color: Colors.white,
                    ),
                    onTap: () => AppRouter.pop(),
                  ),
                  const SizedBox(width: 110),
                  // Title
                  const Text(
                    'Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
