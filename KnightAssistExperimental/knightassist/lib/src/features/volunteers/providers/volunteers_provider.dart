import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global/providers/all_providers.dart';
import '../models/volunteer_model.dart';
import '../repositories/volunteers_repository.dart';

final userVolunteerProvider = FutureProvider.autoDispose((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  final volsProv = ref.watch(volunteersProvider);
  return await volsProv.getVolunteer(volunteerId: userId);
});

class VolunteersProvider {
  final VolunteersRepository _volunteersRepository;
  final Ref _ref;

  VolunteersProvider({
    required VolunteersRepository volunteersRepository,
    required Ref ref,
  })  : _volunteersRepository = volunteersRepository,
        _ref = ref,
        super();

  Future<VolunteerModel> getVolunteer({
    required String volunteerId,
  }) async {
    final queryParams = {
      'userID': volunteerId,
    };
    return await _volunteersRepository.fetchVolunteer(
        queryParameters: queryParams);
  }

  Future<String> editVolunteer({
    required String volunteerId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
  }) async {
    final data = {
      'id': volunteerId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
    if (data.isEmpty) return "nothing to update";
    return await _volunteersRepository.update(data: data);
  }

  Future<String> deleteVolunteer({
    required String volunteerId,
  }) async {
    final data = {
      'id': volunteerId,
    };
    return await _volunteersRepository.delete(data: data);
  }

  Future<List<VolunteerModel>> getVolunteersInOrg({
    required String orgId,
  }) async {
    final queryParams = {
      'organizationID': orgId,
    };
    return await _volunteersRepository.fetchVolunteersInOrg(
        queryParameters: queryParams);
  }

  Future<List<VolunteerModel>> getEventRegisteredVolunteers({
    required String eventId,
  }) async {
    final queryParams = {
      'eventID': eventId,
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
    final authProv = _ref.watch(authProvider.notifier);
    final data = {
      'organizationID': orgId,
      'userID': authProv.currentUserId,
    };
    return await _volunteersRepository.addFavoriteOrg(data: data);
  }

  Future<String> removeFavoriteOrg({
    required String orgId,
  }) async {
    final authProv = _ref.watch(authProvider.notifier);
    final data = {
      'organizationID': orgId,
      'userID': authProv.currentUserId,
    };
    return await _volunteersRepository.removeFavoriteOrg(data: data);
  }
}
