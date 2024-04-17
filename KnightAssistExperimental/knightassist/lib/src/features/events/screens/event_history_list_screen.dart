import 'package:flutter/material.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../../../global/widgets/custom_drawer.dart';
import '../../../global/widgets/custom_top_bar.dart';
import '../widgets/event_history_list/event_history_list.dart';

class EventHistoryListScreen extends StatelessWidget {
  EventHistoryListScreen({super.key});
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
              title: 'Event History',
            ),
            const Expanded(
              child: EventHistoryList(),
            )
          ],
        ),
      ),
    );
  }
}
