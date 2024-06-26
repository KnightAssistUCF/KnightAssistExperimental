import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../global/widgets/custom_date_picker.dart';
import '../../../../helpers/constants/app_colors.dart';
import '../../providers/filter_providers.codegen.dart';

class FiltersListView extends HookConsumerWidget {
  final ScrollController scrollController;

  const FiltersListView({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDateController = useValueNotifier<DateTime?>(null);

    useEffect(
      () {
        eventDateController.value = ref.read(eventDateFilterProvider);
        return null;
      },
      [],
    );

    return ListView(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        // Upcoming or not

        // Event Date
        CustomDatePicker(
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          dateNotifier: eventDateController,
          onDateChanged: (value) {
            ref.read(eventDateFilterProvider.notifier).state = value;
          },
          dateFormat: DateFormat('d MMMM, y'),
          helpText: 'Select an event date',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          pickerStyle: const CustomDatePickerStyle(
            floatingText: 'Event On',
            floatingTextStyle: TextStyle(color: AppColors.textWhite80Color),
          ),
        ),
      ],
    );
  }
}
