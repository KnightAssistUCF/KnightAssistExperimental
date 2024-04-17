import 'package:flutter/material.dart';
import 'package:knightassist/src/features/events/widgets/events_list/org_events_list.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../widgets/events_list/search_and_filters_bar.dart';
import '../widgets/events_list/events_list.dart';

class OrgEventsListScreen extends StatelessWidget {
  final String org;
  OrgEventsListScreen({super.key, required this.org});
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
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            CustomTopBar(
              scaffoldKey: _scaffoldKey,
              title: 'Events',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: SearchAndFiltersBar(),
            ),
            Expanded(
              child: OrgEventsList(org: org),
            )
          ],
        ),
      ),
    );
  }
}
