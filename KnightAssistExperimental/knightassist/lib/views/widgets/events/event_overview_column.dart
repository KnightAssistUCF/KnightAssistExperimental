import 'package:flutter/material.dart';
import 'package:knightassist/helper/extensions/context_extensions.dart';
import 'package:knightassist/views/widgets/common/ratings.dart';

import '../../../models/event_model.dart';

class EventOverviewColumn extends StatelessWidget {
  const EventOverviewColumn({
    Key? key,
    required this.event,
  }) : super(key: key);

  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name
        Text(
          event.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.headline2.copyWith(
            color: Colors.black,
            fontSize: 21,
          ),
        ),

        const SizedBox(height: 13),

        // Ratings
        Ratings(rating: event.rating),

        const Text(
          '...',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
            height: 1,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
