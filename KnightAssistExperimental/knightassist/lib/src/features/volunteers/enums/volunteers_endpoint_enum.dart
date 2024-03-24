// ignore_for_file: constant_identifier_names

enum VolunteersEndpoint {
  FETCH_VOLUNTEER,
  EDIT_VOLUNTEER,
  DELETE_VOLUNTEER,

  FETCH_VOLUNTEERS_IN_ORG,
  FETCH_EVENT_ATTENDEES,

  FETCH_LEADERBOARD,
  FETCH_ORG_LEADERBOARD,

  ADD_FAVORITE_ORG,
  REMOVE_FAVORITE_ORG;

  const VolunteersEndpoint();

  String route() {
    switch (this) {
      case VolunteersEndpoint.FETCH_VOLUNTEER:
        return 'searchUser';
      case VolunteersEndpoint.EDIT_VOLUNTEER:
        return 'editUserProfile';
      case VolunteersEndpoint.DELETE_VOLUNTEER:
        return 'userDelete';
      case VolunteersEndpoint.ADD_FAVORITE_ORG:
        return 'addFavoriteOrg';
      case VolunteersEndpoint.REMOVE_FAVORITE_ORG:
        return 'removeFavoriteOrg';
      case VolunteersEndpoint.FETCH_VOLUNTEERS_IN_ORG:
        return 'loadAllStudentsInOrganization';
      case VolunteersEndpoint.FETCH_EVENT_ATTENDEES:
        return 'loadAllEventAttendees';
      case VolunteersEndpoint.FETCH_LEADERBOARD:
        return 'allStudentsRanking';
      case VolunteersEndpoint.FETCH_ORG_LEADERBOARD:
        return 'perOrgLeaderboard';
    }
  }
}
