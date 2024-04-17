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
      ..invalidate(eventDateFilterProvider)
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
              filtersProvider.select((value) => value.isNotEmpty),
            );
            return hasFilters ? child! : const SizedBox(width: 50, height: 30);
          },
          child: CustomTextButton.gradient(
            width: 60,
            height: 30,
            gradient: AppColors.buttonGradientPrimary,
            onPressed: () => _onResetTap(ref),
            child: const Center(
              child: CustomText(
                'Reset',
                fontSize: 13,
                color: Colors.white,
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
