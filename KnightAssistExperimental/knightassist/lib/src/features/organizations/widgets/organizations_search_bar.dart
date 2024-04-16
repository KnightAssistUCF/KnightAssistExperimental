import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global/widgets/custom_text_field.dart';
import '../../../helpers/constants/app_colors.dart';
import '../providers/search_providers.codegen.dart';

class OrganizationsSearchBar extends ConsumerWidget {
  const OrganizationsSearchBar({super.key});

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
              contentPadding: const EdgeInsets.fromLTRB(12, 13, 1, 13),
              onChanged: (searchTerm) => ref
                  .read(searchFilterProvider.notifier)
                  .update((_) => searchTerm ?? ''),
              hintText: 'Search by name',
              hintStyle: const TextStyle(
                color: AppColors.textLightGreyColor,
              ),
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              prefix: const Icon(
                Icons.search_rounded,
                size: 22,
                color: Colors.black,
              ),
            ),
          ),

          // If we add filters, they will be here
        ],
      ),
    );
  }
}
