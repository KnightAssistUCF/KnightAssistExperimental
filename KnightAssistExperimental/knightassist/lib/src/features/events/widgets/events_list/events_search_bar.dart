import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../global/widgets/custom_text_field.dart';
import '../../providers/search_providers.codegen.dart';

class EventsSearchBar extends ConsumerWidget {
  const EventsSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Field
          Expanded(
            child: CustomTextField(
              onChanged: (searchTerm) => ref
                  .read(searchProvider.notifier)
                  .update((_) => searchTerm ?? ''),
              textInputAction: TextInputAction.search,
              prefix: const Icon(
                Icons.search_rounded,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),

          // If we add filter options, they will be here
        ],
      ),
    );
  }
}
