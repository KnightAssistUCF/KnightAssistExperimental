import '../../../helpers/typedefs.dart';

class AnnouncementModel {
  const AnnouncementModel({
    required this.title,
    required this.content,
    required this.date,
  });

  final String title;
  final String content;
  final DateTime date;

  static AnnouncementModel fromJson(JSON json) {
    return AnnouncementModel(
      title: json['title'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
