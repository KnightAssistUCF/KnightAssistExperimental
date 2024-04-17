import '../../../helpers/typedefs.dart';

class AnnouncementModel {
  const AnnouncementModel({
    required this.title,
    required this.content,
    required this.date,
    required this.organizationName,
  });

  final String title;
  final String content;
  final DateTime date;
  final String? organizationName;

  static AnnouncementModel fromJson(JSON json) {
    return AnnouncementModel(
      title: json['title'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      organizationName: json['organizationName'] as String?,
    );
  }
}
