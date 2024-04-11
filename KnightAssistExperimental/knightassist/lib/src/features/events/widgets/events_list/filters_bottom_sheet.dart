import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/filter_providers.codegen.dart';

import '../../../../helpers/constants/app_colors.dart';

import '../../../../config/routing/routing.dart';

import '../../../../global/widgets/custom_scrollable_bottom_sheet.dart';
import '../../../../global/widgets/custom_text.dart';
import '../../../../global/widgets/custom_text_button.dart';

import 'filters_list_view.dart';

class FiltersBottomSheet extends ConsumerWidget {
  const FiltersBottomSheet({super.key});

  void _onResetTap(WidgetRef ref) {
    ref
      ..invalidate(searchFilterProvider)
      ..invalidate(filtersProvider);
    AppRouter.pop();
  }

  void _onSaveTap(WidgetRef ref) {
    ref.invalidate(filtersProvider);
    AppRouter.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: CustomScrollableBottomSheet(
        titleText: 'Filters',
        leading: Consumer(
          builder: (_, ref, child) {
            final hasFilters = ref.watch(
              // length 2 because is_active is always present + any additional filters
              filtersProvider.select((value) => value.length >= 2),
            );
            return hasFilters ? child! : const SizedBox(width: 50, height: 30);
          },
          child: GestureDetector(
            onTap: () => _onResetTap(ref),
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: CustomText(
                'Reset',
                fontSize: 16,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        trailing: CustomTextButton.gradient(
          width: 60,
          height: 30,
          gradient: AppColors.buttonGradientPrimary,
          onPressed: () => _onSaveTap(ref),
          child: const Center(
            child: CustomText(
              'Apply',
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
        builder: (_, scrollController) => FiltersListView(
          scrollController: scrollController,
        ),
      ),
    );
  }
}
