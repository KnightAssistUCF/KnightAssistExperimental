import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/features/auth/enums/user_role_enum.dart';
import 'package:knightassist/src/global/providers/all_providers.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

import '../../../core/core.dart';
import '../models/announcement_model.dart';
import '../repositories/announcements_repository.dart';

final announcementsListProvider =
    FutureProvider.autoDispose<List<AnnouncementModel>>((ref) async {
  final authProv = ref.watch(authProvider.notifier);
  if (authProv.currentUserRole == UserRole.VOLUNTEER) {
    return await ref
        .watch(announcementsProvider)
        .getFavoritedOrgAnnouncements(userId: authProv.currentUserId);
  }
  return await ref
      .watch(announcementsProvider)
      .getOwnOrgAnnouncements(orgId: authProv.currentUserId);
});

final announcementStateProvider = StateProvider<FutureState<String>>((ref) {
  return const FutureState<String>.idle();
});

class AnnouncementsProvider {
  final AnnouncementsRepository _announcementsRepository;
  final Ref _ref;

  AnnouncementsProvider({
    required AnnouncementsRepository announcementsRepository,
    required Ref ref,
  })  : _announcementsRepository = announcementsRepository,
        _ref = ref,
        super();

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

  Future<void> createAnnouncement({
    required String orgId,
    required String title,
    required String content,
  }) async {
    final data = <String, Object>{
      'organizationID': orgId,
      'title': title,
      'content': content,
    };

    final announcementStateProv = _ref.read(announcementStateProvider.notifier);
    announcementStateProv.state = const FutureState<String>.idle();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      announcementStateProv.state = const FutureState<String>.loading();
    });

    try {
      final temp = await _announcementsRepository.addAnnouncement(data: data);
      announcementStateProv.state = FutureState<String>.data(data: temp);
    } on CustomException catch (e) {
      announcementStateProv.state = FutureState.failed(reason: e.message);
    }
  }

  Future<void> editAnnouncement({
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

    final announcementStateProv = _ref.read(announcementStateProvider.notifier);
    announcementStateProv.state = const FutureState<String>.idle();

    await Future<void>.delayed(const Duration(seconds: 3)).then((_) {
      announcementStateProv.state = const FutureState<String>.loading();
    });

    try {
      final temp = await _announcementsRepository.editAnnouncement(data: data);
      announcementStateProv.state = FutureState<String>.data(data: temp);
    } on CustomException catch (e) {
      announcementStateProv.state = FutureState.failed(reason: e.message);
    }
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

  Future<List<AnnouncementModel>> getOwnOrgAnnouncements({
    required String orgId,
  }) async {
    final queryParams = <String, Object>{
      'organizationID': orgId,
    };
    return _announcementsRepository.fetchOwnOrgAnnouncements(
        queryParameters: queryParams);
  }
}
