import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/organizations/models/organization_model.dart';
import 'package:knightassist/src/features/organizations/providers/organizations_provider.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/widgets/scrollable_column.dart';

import '../../../config/routing/routing.dart';
import '../../../global/widgets/tag.dart';
import '../../../helpers/constants/app_sizes.dart';
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
                    Text(
                      org!.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
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
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Text("About")),
                Tab(icon: Text("Contact")),
                Tab(icon: Text("Tags")),
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
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          organization.contacts?.socialMedia?.instagram == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contacts?.socialMedia?.instagram ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.instagram)),
                          organization.contacts?.socialMedia?.facebook == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contacts?.socialMedia?.facebook ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.facebook)),
                          organization.contacts?.socialMedia?.twitter == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contacts?.socialMedia?.twitter ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon:
                                      const FaIcon(FontAwesomeIcons.xTwitter)),
                          organization.contacts?.socialMedia?.linkedin == ''
                              ? const SizedBox(
                                  height: 0,
                                )
                              : IconButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(organization
                                            .contacts?.socialMedia?.linkedin ??
                                        '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  icon: const FaIcon(FontAwesomeIcons.linkedin))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'mailto:${organization.contacts?.email}?subject=Hello from KnightAssist&body=I am interested in volunteering with your organization!	');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.email_outlined),
                              Text(
                                organization.contacts?.email ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              final Uri url = Uri.parse(
                                  'tel:${organization.contacts?.phone}');
                              if (!await launchUrl(url)) {
                                throw Exception('Could not launch $url');
                              }
                            },
                            child: Wrap(children: [
                              const Icon(Icons.phone_rounded),
                              Text(
                                organization.contacts?.phone ?? '',
                                style: const TextStyle(fontSize: 20),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      organization.contacts?.website == ''
                          ? const SizedBox(height: 0)
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: TextButton(
                                  onPressed: () async {
                                    final Uri url = Uri.parse(
                                        organization.contacts?.website ?? '');
                                    if (!await launchUrl(url)) {
                                      throw Exception('Could not launch $url');
                                    }
                                  },
                                  child: Wrap(children: [
                                    const Icon(Icons.computer),
                                    Text(
                                      organization.contacts?.website ?? '',
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                      const Text("Working Hours per Week"),
                      const Text("Monday:"),
                      organization.workingHours?.monday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.monday!.start!),
                      const Text("-"),
                      organization.workingHours?.monday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.monday!.end!),
                      const Text("Tuesday:"),
                      organization.workingHours?.tuesday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.tuesday!.start!),
                      const Text("-"),
                      organization.workingHours?.tuesday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.tuesday!.end!),
                      const Text("Wednesday:"),
                      organization.workingHours?.wednesday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.wednesday!.start!),
                      const Text("-"),
                      organization.workingHours?.wednesday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.wednesday!.end!),
                      const Text("Thursday:"),
                      organization.workingHours?.thursday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.thursday!.start!),
                      const Text("-"),
                      organization.workingHours?.thursday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.thursday!.end!),
                      const Text("Friday:"),
                      organization.workingHours?.friday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.friday!.start!),
                      const Text("-"),
                      organization.workingHours?.friday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.friday!.end!),
                      const Text("Saturday:"),
                      organization.workingHours?.saturday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.saturday!.start!),
                      const Text("-"),
                      organization.workingHours?.saturday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.saturday!.end!),
                      const Text("Sunday:"),
                      organization.workingHours?.sunday?.start == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.sunday!.start!),
                      const Text("-"),
                      organization.workingHours?.sunday?.end == null
                          ? const SizedBox(height: 0)
                          : Text(organization.workingHours!.sunday!.end!),
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
                                    style: TextStyle(fontSize: Sizes.p20),
                                  ),
                                )
                              : Wrap(children: [
                                  for (var tag in organization.categoryTags)
                                    Tag(tag: tag)
                                ])),
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
