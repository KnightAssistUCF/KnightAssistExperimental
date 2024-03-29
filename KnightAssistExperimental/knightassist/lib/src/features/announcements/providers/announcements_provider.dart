import '../models/announcement_model.dart';
import '../repositories/announcements_repository.dart';

class AnnouncementsProvider {
  final AnnouncementsRepository _announcementsRepository;

  AnnouncementsProvider(this._announcementsRepository);

  Future<List<AnnouncementModel>> getAllAnnouncements() async {
    return _announcementsRepository.fetchAllAnnouncements();
  }

  Future<AnnouncementModel> getAnnouncement(
      {required String orgId, required String title}) async {
    final queryParams = <String, Object>{
      'organizationID': orgId,
      'title': title,
    };
    return _announcementsRepository.fetchAnnouncement(
        queryParameters: queryParams);
  }

  Future<String> createAnnouncement({
    required String orgId,
    required String title,
    required String content,
  }) async {
    final data = <String, Object>{
      'organizationID': orgId,
      'title': title,
      'content': content,
    };
    return _announcementsRepository.addAnnouncement(data: data);
  }

  Future<String> editAnnouncement({
    required String orgId,
    required String oldTitle,
    String? newTitle,
    String? newContent,
  }) async {
    final data = <String, Object>{
      'organizationID': orgId,
      'oldTitle': oldTitle,
      if (newTitle != null) 'newTitle': newTitle,
      if (newContent != null) 'newContent': newContent,
    };
    return _announcementsRepository.editAnnouncement(data: data);
  }

  Future<String> deleteAnnouncement({
    required String orgId,
    required String title,
  }) async {
    final data = <String, Object>{
      'organizationID': orgId,
      'title': title,
    };
    return _announcementsRepository.deleteAnnouncement(data: data);
  }

  Future<List<AnnouncementModel>> getFavoritedOrgAnnouncements({
    required String userId,
  }) async {
    final queryParams = <String, Object>{
      'studentID': userId,
    };
    return _announcementsRepository.fetchFavoritedOrgAnnouncements(
        queryParameters: queryParams);
  }
}
