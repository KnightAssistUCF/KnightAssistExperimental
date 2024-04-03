import 'package:flutter/material.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';

import '../widgets/announcements_list.dart';

class AnnouncementsListScreen extends StatelessWidget {
  AnnouncementsListScreen({super.key});
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            CustomTopBar(
              scaffoldKey: _scaffoldKey,
              title: 'Announcements',
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: AnnouncementsList(),
            ),
          ],
        ),
      ),
    );
  }
}
