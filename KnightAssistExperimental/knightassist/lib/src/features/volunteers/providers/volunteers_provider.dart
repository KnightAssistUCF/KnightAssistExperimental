import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:knightassist/src/core/core.dart';
import 'package:knightassist/src/features/auth/providers/auth_provider.dart';
import 'package:knightassist/src/global/states/future_state.codegen.dart';

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

  Future<void> editVolunteer({
    required String volunteerId,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    List<String>? categoryTags,
    bool? recieveEmails,
  }) async {
    final data = {
      'id': volunteerId,
      if (firstName != null) 'firstName': firstName,
      if (lastName != null) 'lastName': lastName,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (categoryTags != null) 'categoryTags': categoryTags,
      if (recieveEmails != null) 'recieveEmails': recieveEmails,
    };

    final editProfileStateProv = _ref.read(editProfileStateProvider.notifier);
    editProfileStateProv.state = const FutureState.idle();

    await Future<void>.delayed(const Duration(milliseconds: 100)).then((_) {
      editProfileStateProv.state = const FutureState.loading();
    });

    try {
      final response = await _volunteersRepository.update(data: data);
      editProfileStateProv.state = FutureState.data(data: response);
    } on CustomException catch (e) {
      editProfileStateProv.state = FutureState.failed(reason: e.message);
    }
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
