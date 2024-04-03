import '../../../helpers/typedefs.dart';
import '../../announcements/models/announcement_model.dart';

class OrganizationModel {
  const OrganizationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.profilePicPath,
    required this.backgroundPicPath,
    required this.categoryTags,
    required this.favorites,
    required this.announcements,
    this.contacts,
    required this.isActive,
    required this.eventHappeningNow,
    this.workingHours,
  });

  final String id;
  final String name;
  final String email;
  final String description;
  final String profilePicPath;
  final String backgroundPicPath;
  final List<String> categoryTags;
  final List<String> favorites;
  final List<AnnouncementModel> announcements;
  final ContactModel? contacts;
  final bool isActive;
  final bool eventHappeningNow;
  final WorkingHoursModel? workingHours;

  static OrganizationModel fromJson(JSON json) {
    return OrganizationModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String,
      profilePicPath: json['profilePicPath'] as String,
      backgroundPicPath: json['backgroundURL'] as String,
      categoryTags: (json['categoryTags'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      favorites:
          (json['favorites'] as List<dynamic>).map((e) => e as String).toList(),
      announcements: (json['updates'] as List<dynamic>)
          .map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      contacts: (json['contacts'] != null)
          ? ContactModel.fromJson(json['contactModel'] as Map<String, dynamic>)
          : null,
      isActive: json['isActive'] as bool,
      eventHappeningNow: json['eventHappeningNow'] as bool,
      workingHours: (json['workingHoursPerWeek'] != null)
          ? WorkingHoursModel.fromJson(
              json['workingHoursPerWeek'] as Map<String, dynamic>)
          : null,
    );
  }
}

class ContactModel {
  const ContactModel({
    this.socialMedia,
    this.email,
    this.phone,
    this.website,
  });

  final SocialMediaModel? socialMedia;
  final String? email;
  final String? phone;
  final String? website;

  static ContactModel fromJson(JSON json) {
    return ContactModel(
      socialMedia: SocialMediaModel.fromJson(
          json['socialMedia'] as Map<String, dynamic>),
      email: json['email'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
    );
  }
}

class SocialMediaModel {
  const SocialMediaModel({
    this.facebook,
    this.twitter,
    this.instagram,
    this.linkedin,
  });

  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;

  static SocialMediaModel fromJson(JSON json) {
    return SocialMediaModel(
      facebook: json['facebook'] as String,
      twitter: json['twitter'] as String,
      instagram: json['instagram'] as String,
      linkedin: json['linkedin'] as String,
    );
  }
}

class WorkingHoursModel {
  const WorkingHoursModel({
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
  });

  final WorkdayModel? sunday;
  final WorkdayModel? monday;
  final WorkdayModel? tuesday;
  final WorkdayModel? wednesday;
  final WorkdayModel? thursday;
  final WorkdayModel? friday;
  final WorkdayModel? saturday;

  static WorkingHoursModel fromJson(JSON json) {
    return WorkingHoursModel(
      sunday: WorkdayModel.fromJson(json['sunday'] as Map<String, dynamic>),
      monday: WorkdayModel.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: WorkdayModel.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday:
          WorkdayModel.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: WorkdayModel.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: WorkdayModel.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: WorkdayModel.fromJson(json['saturday'] as Map<String, dynamic>),
    );
  }
}

class WorkdayModel {
  const WorkdayModel({
    this.start,
    this.end,
  });

  final String? start;
  final String? end;

  static WorkdayModel fromJson(JSON json) {
    return WorkdayModel(
      start: json['start'],
      end: json['end'],
    );
  }
}
