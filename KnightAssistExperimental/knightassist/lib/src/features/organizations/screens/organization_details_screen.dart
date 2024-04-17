import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:knightassist/src/features/events/models/event_model.dart';
import 'package:knightassist/src/features/events/providers/feedback_provider.dart';
import 'package:knightassist/src/features/events/widgets/feedback_list/feedback_list.dart';
import 'package:knightassist/src/global/widgets/async_value_widget.dart';
import 'package:knightassist/src/global/widgets/custom_refresh_indicator.dart';
import 'package:knightassist/src/global/widgets/custom_text.dart';
import 'package:knightassist/src/global/widgets/responsive_center.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/models/organization_model.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../global/widgets/tag.dart';
import '../../../helpers/constants/app_colors.dart';
import '../../../helpers/constants/app_sizes.dart';
import '../../../helpers/constants/app_styles.dart';
import '../../auth/enums/user_role_enum.dart';
import '../widgets/favorite_button.dart';

class OrganizationDetailsScreen extends ConsumerWidget {
  const OrganizationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authProv = ref.watch(authProvider.notifier);
    final org = ref.watch(currentOrganizationProvider);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: ScrollableColumn(
            children: [
              // Top Bar
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 20),
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
                    SizedBox(
                      width: 275,
                      child: CustomText(
                        org!.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                  ],
                ),
              ),

              // Org Details
              Padding(
                padding: const EdgeInsets.all(Sizes.p16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Organization top
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: org.backgroundPicPath!,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                height: 200,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: imageProvider,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Wrap(
                                children: [
                                  Text(
                                    org.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 26,
                                    ),
                                  ),
                                  Visibility(
                                    visible: authProv.currentUserRole ==
                                        UserRole.VOLUNTEER,
                                    child: FavoriteButton(org: org),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 150,
                          child: CachedNetworkImage(
                            imageUrl: org.profilePicPath!,
                            imageBuilder: (context, imageProvider) => Container(
                              padding: const EdgeInsets.all(5),
                              height: 64,
                              width: 64,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: imageProvider,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 320,
                      child: TabBarOrg(organization: org),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class TabBarOrg extends StatefulWidget {
  final OrganizationModel organization;

  const TabBarOrg({super.key, required this.organization});

  @override
  State<TabBarOrg> createState() => _TabBarOrgState();
}

class _TabBarOrgState extends State<TabBarOrg> with TickerProviderStateMixin {
  late final TabController _tabController;
  late final OrganizationModel organization;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    organization = widget.organization;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.phone_rounded)),
                Tab(icon: Icon(Icons.tag)),
                Tab(icon: Icon(Icons.messenger))
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          organization.description,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      organization.contacts.socialMedia == null &&
                              organization.contacts.email == null &&
                              organization.contacts.phone == null &&
                              organization.contacts.website == null &&
                              organization.workingHours == null
                          ? const Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "This organization has no tags.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                      organization.contacts.socialMedia != null
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  organization.contacts.socialMedia!.facebook !=
                                          null
                                      ? IconButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                organization.contacts
                                                    .socialMedia!.facebook!);
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.facebook),
                                        )
                                      : const SizedBox.shrink(),
                                  organization.contacts.socialMedia!.twitter !=
                                          null
                                      ? IconButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                organization.contacts
                                                    .socialMedia!.twitter!);
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.xTwitter),
                                        )
                                      : const SizedBox.shrink(),
                                  organization.contacts.socialMedia!
                                              .instagram !=
                                          null
                                      ? IconButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                organization.contacts
                                                    .socialMedia!.instagram!);
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.instagram),
                                        )
                                      : const SizedBox.shrink(),
                                  organization.contacts.socialMedia!.linkedin !=
                                          null
                                      ? IconButton(
                                          onPressed: () async {
                                            final Uri url = Uri.parse(
                                                organization.contacts
                                                    .socialMedia!.linkedin!);
                                            if (!await launchUrl(url)) {
                                              throw Exception(
                                                  'Could not launch $url');
                                            }
                                          },
                                          icon: const FaIcon(
                                              FontAwesomeIcons.linkedin),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      organization.contacts.email != null
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.email_outlined,
                                    size: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                  Insets.gapW10,
                                  Expanded(
                                    child: CustomText(
                                      organization.contacts.email!,
                                      maxLines: 2,
                                      fontSize: 14,
                                      color: AppColors.textWhite80Color,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      organization.contacts.phone != null
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.phone_rounded,
                                    size: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                  Insets.gapW10,
                                  Expanded(
                                    child: CustomText(
                                      organization.contacts.phone!,
                                      maxLines: 2,
                                      fontSize: 14,
                                      color: AppColors.textWhite80Color,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      organization.contacts.website != null
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.globe,
                                    size: 24,
                                    color: AppColors.primaryColor,
                                  ),
                                  Insets.gapW10,
                                  Expanded(
                                    child: CustomText(
                                      organization.contacts.website!,
                                      maxLines: 2,
                                      fontSize: 14,
                                      color: AppColors.textWhite80Color,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      organization.workingHours != null
                          ? Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Working Hours per Week:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14),
                                  ),
                                  organization.workingHours!.monday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.monday.end !=
                                              null
                                      ? CustomText(
                                          'Monday: ${TimeOfDay.fromDateTime(organization.workingHours!.monday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.monday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.tuesday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.tuesday.end !=
                                              null
                                      ? CustomText(
                                          'Tuesday: ${TimeOfDay.fromDateTime(organization.workingHours!.tuesday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.tuesday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.wednesday.start !=
                                              null &&
                                          organization.workingHours!.wednesday
                                                  .end !=
                                              null
                                      ? CustomText(
                                          'Wednesday: ${TimeOfDay.fromDateTime(organization.workingHours!.wednesday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.wednesday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.thursday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.thursday.end !=
                                              null
                                      ? CustomText(
                                          'Thursday: ${TimeOfDay.fromDateTime(organization.workingHours!.thursday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.thursday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.friday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.friday.end !=
                                              null
                                      ? CustomText(
                                          'Friday: ${TimeOfDay.fromDateTime(organization.workingHours!.friday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.friday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.saturday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.saturday.end !=
                                              null
                                      ? CustomText(
                                          'Saturday: ${TimeOfDay.fromDateTime(organization.workingHours!.saturday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.saturday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                  organization.workingHours!.sunday.start !=
                                              null &&
                                          organization
                                                  .workingHours!.sunday.end !=
                                              null
                                      ? CustomText(
                                          'Sunday: ${TimeOfDay.fromDateTime(organization.workingHours!.sunday.start!).format(context)} - ${TimeOfDay.fromDateTime(organization.workingHours!.sunday.end!).format(context)}',
                                          maxLines: 2,
                                          fontSize: 14,
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: organization.categoryTags.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "This organization has no tags.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : Wrap(children: [
                                  for (var tag in organization.categoryTags)
                                    Tag(tag: tag)
                                ])),
                    ],
                  ),
                  ListView(
                    children: const [
                      SizedBox(
                        height: 240,
                        width: 100,
                        child: LocalFeedbackList(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LocalFeedbackList extends ConsumerWidget {
  const LocalFeedbackList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AsyncValueWidget(
      value: ref.watch(orgFeedbackProvider),
      loading: () => const Padding(
        padding: EdgeInsets.all(8),
        child: CustomCircularLoader(),
      ),
      error: (error, st) => Padding(
        padding: const EdgeInsets.all(8),
        child: ErrorResponseHandler(
          error: error,
          retryCallback: () => ref.refresh(orgFeedbackProvider),
          stackTrace: st,
        ),
      ),
      emptyOrNull: () => const EmptyStateWidget(
        height: 395,
        width: double.infinity,
        margin: EdgeInsets.only(top: 8),
        title: 'No feedback found',
      ),
      data: (feedback) {
        num ratingSum = 0;
        num avgRating = 0;
        for (int i = 0; i < feedback.length; i++) {
          ratingSum += feedback[i].rating;
        }
        avgRating = ratingSum / feedback.length;
        String avgRatingText =
            avgRating.toStringAsFixed(2); // show 2 decimal places
        return Column(children: [
          Text('Average Rating: $avgRatingText',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              )),
          RatingBarIndicator(
            rating: avgRating.toDouble(),
            itemSize: 20.0,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feedback.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              itemBuilder: (_, i) =>
                  LocalFeedbackListItem(feedback: feedback[i]),
            ),
          ),
        ]);
      },
    );
  }
}

class LocalFeedbackListItem extends StatelessWidget {
  final FeedbackModel feedback;

  const LocalFeedbackListItem({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxContentWidth: 220,
      child: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black26,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(0.05),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    feedback.eventName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    feedback.volunteerName,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),
                    textAlign: TextAlign.start,
                  ),
                ),
                RatingBarIndicator(
                  rating: feedback.rating.toDouble(),
                  itemSize: 20.0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    feedback.content,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    TimeOfDay.fromDateTime(feedback.timeSubmitted)
                        .format(context),
                    style: const TextStyle(fontWeight: FontWeight.w400),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
