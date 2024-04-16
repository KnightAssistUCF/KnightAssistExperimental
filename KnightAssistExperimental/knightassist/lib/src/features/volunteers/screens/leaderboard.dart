import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/volunteers/models/volunteer_model.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_circular_loader.dart';
import 'package:knightassist/src/global/widgets/custom_drawer.dart';
import 'package:knightassist/src/global/widgets/custom_refresh_indicator.dart';
import 'package:knightassist/src/global/widgets/custom_top_bar.dart';
import 'package:knightassist/src/helpers/constants/app_colors.dart';

import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../helpers/constants/app_styles.dart';
import '../providers/volunteers_provider.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({super.key});
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
              title: 'Leaderboard',
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: Leaderboard(),
            )
          ],
        ),
      ),
    );
  }
}

class Leaderboard extends ConsumerWidget {
  const Leaderboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(leaderboardProvider),
      child: AsyncValueWidget<List<VolunteerModel>>(
        value: ref.watch(leaderboardProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: ErrorResponseHandler(
              error: error,
              retryCallback: () => ref.refresh(leaderboardProvider),
              stackTrace: st,
            ),
          );
        },
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No volunteers found',
        ),
        data: (volunteers) {
          return ListView.separated(
            itemCount: volunteers.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => LeaderboardItem(
              volunteer: volunteers[i],
              rank: i + 1,
            ),
          );
        },
      ),
    );
  }
}

class LeaderboardItem extends ConsumerWidget {
  final VolunteerModel volunteer;
  final int rank;

  const LeaderboardItem({
    super.key,
    required this.volunteer,
    required this.rank,
  });

  Color? _getColor() {
    if (rank == 1) {
      return Colors.amber;
    } else if (rank == 2) {
      return Colors.lightBlue;
    } else if (rank == 3) {
      return Colors.orange;
    } else {
      return AppColors.tertiaryColor;
    }
  }

  String getTimeStringFromDouble(double value) {
    if (value < 0) return 'Invalid Value';
    int flooredValue = value.floor();
    double decimalValue = value - flooredValue;
    String hourValue = getHourString(flooredValue);
    String minuteString = getMinuteString(decimalValue);

    return '$hourValue:$minuteString';
  }

  String getMinuteString(double decimalValue) {
    return '${(decimalValue * 60).toInt()}'.padLeft(2, '0');
  }

  String getHourString(int flooredValue) {
    return '$flooredValue';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: _getColor(),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: volunteer.profilePicPath!,
              imageBuilder: (context, imageProvider) => Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            Column(
              children: [
                Text(
                  '${volunteer.firstName} ${volunteer.lastName}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                  textAlign: TextAlign.start,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${getTimeStringFromDouble(volunteer.totalHours.toDouble())} hours",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 15),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: _getColor(),
                  border: Border.all()),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  rank.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
