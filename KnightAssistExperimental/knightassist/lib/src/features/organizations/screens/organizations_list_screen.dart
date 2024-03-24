import 'package:flutter/material.dart';

import '../../../global/widgets/custom_text.dart';
import '../../../helpers/constants/app_styles.dart';
import '../widgets/organizations_list.dart';
import '../widgets/organizations_search_bar.dart';

class OrganizationsListScreen extends StatelessWidget {
  const OrganizationsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Insets.gapH20,

            // Title
            CustomText.title('Organizations'),

            Insets.gapH20,

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: OrganizationsSearchBar(),
            ),

            const Expanded(
              child: OrganizationsList(),
            )
          ],
        ),
      ),
    );
  }
}
