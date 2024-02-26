import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../helper/utils/constants.dart';
import '../../../helper/extensions/context_extensions.dart';

import '../../../providers/all_providers.dart';

class VolunteerProfileDetails extends HookConsumerWidget {
  const VolunteerProfileDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Name

        // Email
        Text(
          'Email',
          style: context.bodyText1.copyWith(
              color: Constants.primaryColor,
              fontSize: 26,
              fontWeight: FontWeight.bold),
        ),
        Text(
          authProv.currentUserEmail,
          style: context.bodyText1.copyWith(
            color: Constants.textWhite80Color,
            fontSize: 18,
          ),
        ),
        const Spacer(),

        // Other info below
      ],
    );
  }
}
