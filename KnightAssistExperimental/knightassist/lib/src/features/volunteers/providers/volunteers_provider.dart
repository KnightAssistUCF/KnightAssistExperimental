import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../global/providers/all_providers.dart';
import '../models/volunteer_model.dart';
import '../repositories/volunteers_repository.dart';

final userVolunteerProvider = FutureProvider.autoDispose((ref) async {
  final userId = ref.watch(authProvider.notifier).currentUserId;
  return await ref.watch(volunteersProvider).getVolunteer(volunteerId: userId);
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
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'userID': volunteerId,
    };
    final temp = await _volunteersRepository.fetchVolunteer(
        queryParameters: queryParams);
    temp.profilePicPath = await imgProv.retrieveImage(type: '3', id: temp.id);
    return temp;
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
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'organizationID': orgId,
    };
    final temp = await _volunteersRepository.fetchVolunteersInOrg(
        queryParameters: queryParams);
    for (VolunteerModel v in temp) {
      v.profilePicPath = await imgProv.retrieveImage(type: '3', id: v.id);
    }
    return temp;
  }

  Future<List<VolunteerModel>> getEventRegisteredVolunteers({
    required String eventId,
  }) async {
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'eventID': eventId,
    };
    final temp = await _volunteersRepository.fetchEventAttendees(
        queryParameters: queryParams);
    for (VolunteerModel v in temp) {
      v.profilePicPath = await imgProv.retrieveImage(type: '3', id: v.id);
    }
    return temp;
  }

  Future<List<VolunteerModel>> getLeaderboard() async {
    final imgProv = _ref.watch(imagesProvider);
    final temp = await _volunteersRepository.fetchLeaderboard();
    for (VolunteerModel v in temp) {
      v.profilePicPath = await imgProv.retrieveImage(type: '3', id: v.id);
    }
    return temp;
  }

  Future<List<VolunteerModel>> getOrgLeaderboard({
    required String orgId,
  }) async {
    final imgProv = _ref.watch(imagesProvider);
    final queryParams = {
      'orgId': orgId,
    };
    final temp = await _volunteersRepository.fetchOrgLeaderboard(
        queryParameters: queryParams);
    for (VolunteerModel v in temp) {
      v.profilePicPath = await imgProv.retrieveImage(type: '3', id: v.id);
    }
    return temp;
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
