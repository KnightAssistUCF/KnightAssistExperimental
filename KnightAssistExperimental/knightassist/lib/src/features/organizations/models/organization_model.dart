import '../../../helpers/typedefs.dart';
import '../../announcements/models/announcement_model.dart';

class OrganizationModel {
  OrganizationModel({
    required this.id,
    required this.name,
    required this.email,
    required this.description,
    required this.profilePicPath,
    required this.backgroundPicPath,
    required this.categoryTags,
    required this.favorites,
    required this.announcements,
    required this.contacts,
    required this.isActive,
    required this.eventHappeningNow,
    required this.workingHours,
  });

  final String id;
  final String name;
  final String email;
  final String description;
  String? profilePicPath;
  String? backgroundPicPath;
  final List<String> categoryTags;
  final List<String> favorites;
  final List<AnnouncementModel> announcements;
  final ContactModel contacts;
  final bool isActive;
  final bool eventHappeningNow;
  final WorkingHoursModel? workingHours;

  static OrganizationModel fromJson(JSON json) {
    return OrganizationModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      description: json['description'] as String? ?? '',
      profilePicPath: json['profilePicPath'] as String?,
      backgroundPicPath: json['backgroundURL'] as String?,
      categoryTags: (json['categoryTags'] != null)
          ? (json['categoryTags'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      favorites: (json['favorites'] != null)
          ? (json['favorites'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      announcements: (json['updates'] != null)
          ? (json['updates'] as List<dynamic>)
              .map((e) => AnnouncementModel.fromJson(e as Map<String, dynamic>))
              .toList()
          : [],
      contacts: (json['contact'] != null)
          ? ContactModel.fromJson(json['contact'] as Map<String, dynamic>)
          : const ContactModel(
              email: null,
              phone: null,
              website: null,
              socialMedia: SocialMediaModel(
                  facebook: null,
                  twitter: null,
                  instagram: null,
                  linkedin: null)),
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
    required this.socialMedia,
    required this.email,
    required this.phone,
    required this.website,
  });

  final SocialMediaModel? socialMedia;
  final String? email;
  final String? phone;
  final String? website;

  static ContactModel fromJson(JSON json) {
    return ContactModel(
      socialMedia: (json['socialMedia'] != null)
          ? SocialMediaModel.fromJson(
              json['socialMedia'] as Map<String, dynamic>)
          : null,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
    );
  }
}

class SocialMediaModel {
  const SocialMediaModel({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.linkedin,
  });

  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? linkedin;

  static SocialMediaModel fromJson(JSON json) {
    return SocialMediaModel(
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      linkedin: json['linkedin'] as String?,
    );
  }
}

class WorkingHoursModel {
  const WorkingHoursModel({
    required this.sunday,
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
  });

  final WorkdayModel sunday;
  final WorkdayModel monday;
  final WorkdayModel tuesday;
  final WorkdayModel wednesday;
  final WorkdayModel thursday;
  final WorkdayModel friday;
  final WorkdayModel saturday;

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
    required this.start,
    required this.end,
  });

  final DateTime? start;
  final DateTime? end;

  static WorkdayModel fromJson(JSON json) {
    return WorkdayModel(
      start: (json['start'] != null)
          ? DateTime.parse(json['start'] as String)
          : null,
      end: (json['end'] != null) ? DateTime.parse(json['end'] as String) : null,
    );
  }
}
