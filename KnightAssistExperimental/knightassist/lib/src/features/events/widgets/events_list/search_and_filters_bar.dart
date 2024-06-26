import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/filter_providers.codegen.dart';

import '../../../../helpers/constants/constants.dart';

import '../../../../global/widgets/custom_text_field.dart';
import 'filters_bottom_sheet.dart';

class SearchAndFiltersBar extends ConsumerWidget {
  const SearchAndFiltersBar({super.key});

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

          Insets.gapW10,

          // Filters button
          InkWell(
            onTap: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const FiltersBottomSheet();
                },
              );
            },
            child: Container(
              height: 47,
              width: 47,
              decoration: const BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: Corners.rounded7,
              ),
              child: const Icon(
                Icons.tune_rounded,
                color: AppColors.textLightGreyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
