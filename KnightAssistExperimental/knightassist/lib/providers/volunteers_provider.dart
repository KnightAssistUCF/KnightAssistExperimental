import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/volunteer_model.dart';
import '../services/repositories/volunteers_repository.dart';
import 'all_providers.dart';

final UserVolunteerProvider = FutureProvider.autoDispose((ref) async {
  final _userId = ref.watch(authProvider.notifier).currentUserId;
  final _volunteersProvider = ref.watch(volunteersProvider);
  return await _volunteersProvider.getVolunteer(volunteerId: _userId);
});

class VolunteersProvider {
  final VolunteersRepository _volunteersRepository;

  VolunteersProvider(this._volunteersRepository);

  Future<VolunteerModel> getVolunteer({
    required String volunteerId,
  }) async {
    final queryParams = {
      'volunteerId': volunteerId,
    };
    return await _volunteersRepository.fetchOne(queryParameters: queryParams);
  }

  Future<String> editVolunteer({
    required VolunteerModel volunteer,
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    final data = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
    if (data.isEmpty) return "nothing to update";
    return await _volunteersRepository.update(data: data);
  }

  Future<String> deleteVolunteer({
    required String volunteerId,
  }) async {
    final data = {
      'volunteerId': volunteerId,
    };
    return await _volunteersRepository.delete(data: data);
  }

  Future<List<VolunteerModel>> getVolunteersInOrg({
    required String orgId,
  }) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _volunteersRepository.fetchVolunteersInOrg(
        queryParameters: queryParams);
  }

  Future<List<VolunteerModel>> getEventAttendees({
    required String eventId,
  }) async {
    final queryParams = {
      'eventId': eventId,
    };
    return await _volunteersRepository.fetchEventAttendees(
        queryParameters: queryParams);
  }

  Future<List<VolunteerModel>> getLeaderboard() async {
    return await _volunteersRepository.fetchLeaderboard();
  }

  Future<List<VolunteerModel>> getOrgLeaderboard({
    required String orgId,
  }) async {
    final queryParams = {
      'orgId': orgId,
    };
    return await _volunteersRepository.fetchOrgLeaderboard(
        queryParameters: queryParams);
  }

  Future<String> addFavoriteOrg({
    required String orgId,
  }) async {
    final data = {
      'orgId': orgId,
    };
    return await _volunteersRepository.addFavoriteOrg(data: data);
  }

  Future<String> removeFavoriteOrg({
    required String orgId,
  }) async {
    final data = {
      'orgId': orgId,
    };
    return await _volunteersRepository.removeFavoriteOrg(data: data);
  }
}
