import 'package:flutter/material.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';

import '../widgets/events_list/search_and_filters_bar.dart';
import '../widgets/events_list/events_list.dart';

class EventsListScreen extends StatelessWidget {
  EventsListScreen({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Expanded(
              child: EventsList(),
            )
          ],
        ),
      ),
    );
  }
}
