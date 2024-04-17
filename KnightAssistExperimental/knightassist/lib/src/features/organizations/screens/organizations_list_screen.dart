import 'package:flutter/material.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../widgets/organizations_list.dart';
import '../widgets/organizations_search_bar.dart';

class OrganizationsListScreen extends StatelessWidget {
  OrganizationsListScreen({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
      ),
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            CustomTopBar(scaffoldKey: _scaffoldKey, title: 'Organizations'),
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
