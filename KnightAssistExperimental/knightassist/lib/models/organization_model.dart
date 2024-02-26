import 'package:freezed_annotation/freezed_annotation.dart';

import '../helper/typedefs.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
class OrganizationModel with _$OrganizationModel {
  factory OrganizationModel(
      {required String? organizationId,
      required String name,
      required String email,
      required String description,
      required String logoUrl,
      required List<String> categoryTags,
      required List<String> favorites,
      // TODO: Announcements
      required String profilePicPath,
      required String calendarLink,
      // TODO: Contact
      required bool isActive,
      required bool eventHappeningNow,
      required String backgroundUrl,
      required String events,
      required String location}) = _OrganizationModel;
}
