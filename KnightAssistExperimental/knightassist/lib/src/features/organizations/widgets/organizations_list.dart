import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global/widgets/async_value_widget.dart';
import '../../../global/widgets/custom_circular_loader.dart';
import '../../../global/widgets/custom_refresh_indicator.dart';
import '../../../global/widgets/empty_state_widget.dart';
import '../../../global/widgets/error_response_handler.dart';
import '../../../helpers/constants/app_styles.dart';
import '../models/organization_model.dart';
import '../providers/search_providers.codegen.dart';
import 'organizations_list_item.dart';

class OrganizationsList extends ConsumerWidget {
  const OrganizationsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomRefreshIndicator(
      onRefresh: () async => ref.refresh(searchProvider),
      child: AsyncValueWidget<List<OrganizationModel>>(
        value: ref.watch(searchedOrgsProvider),
        loading: () => const Padding(
          padding: EdgeInsets.only(top: 70),
          child: CustomCircularLoader(),
        ),
        error: (error, st) => Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: ErrorResponseHandler(
            error: error,
            retryCallback: () => ref.refresh(searchProvider),
            stackTrace: st,
          ),
        ),
        emptyOrNull: () => const EmptyStateWidget(
          height: 395,
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          title: 'No organizations found',
          subtitle: 'Try changing the search term',
        ),
        data: (searchedOrganizations) {
          final orgs = searchedOrganizations;
          return ListView.separated(
            itemCount: orgs.length,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            separatorBuilder: (_, __) => Insets.gapH20,
            itemBuilder: (_, i) => OrganizationsListItem(
              org: orgs[i],
            ),
          );
        },
      ),
    );
  }
}
