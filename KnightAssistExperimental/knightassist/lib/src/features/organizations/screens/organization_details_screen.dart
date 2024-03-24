import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/custom_text_button.dart';
import '../../auth/enums/user_role_enum.dart';

class OrganizationDetailsScreen extends ConsumerWidget {
  const OrganizationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final org = ref.watch(currentOrganizationProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Org Details
          Column(),

          // Edit Button if sponsoring org
          Visibility(
            visible: authProv.currentUserRole == UserRole.ORGANIZATION &&
                authProv.currentUserId == org!.organizationId,
            child: CustomTextButton(
              child: const Center(
                child: Text(
                  'Edit Organization',
                ),
              ),
              onPressed: () {
                AppRouter.pushNamed(Routes.EditOrganizationScreenRoute);
              },
            ),
          ),

          // Favorite button if student
          Visibility(
            visible: authProv.currentUserRole == UserRole.VOLUNTEER,
            child: CustomTextButton(
              child: const Center(
                child: Text(
                  'Favorite',
                ),
              ),
              onPressed: () {
                // Favorite toast
              },
            ),
          ),
        ],
      ),
    );
  }
}
