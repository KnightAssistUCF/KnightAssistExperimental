import 'package:flutter/material.dart';

import '../../../config/routing/routing.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Icon
                  InkResponse(
                    radius: 26,
                    child: const Icon(
                      Icons.arrow_back_sharp,
                      size: 32,
                      color: Colors.white,
                    ),
                    onTap: () => AppRouter.pop(),
                  ),
                  // Title
                  const Text(
                    'Organizations',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
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
