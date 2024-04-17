// ignore_for_file: constant_identifier_names

enum AnnouncementsEndpoint {
  FETCH_ALL_ANNOUNCEMENTS,
  FETCH_FAVORITED_ORG_ANNOUNCEMENTS,
  FETCH_OWN_ORG_ANNOUNCEMENTS,
  FETCH_ANNOUNCEMENT,
  ADD_ANNOUNCEMENT,
  EDIT_ANNOUNCEMENT,
  DELETE_ANNOUNCEMENT;

  const AnnouncementsEndpoint();

  String route() {
    switch (this) {
      case AnnouncementsEndpoint.FETCH_ALL_ANNOUNCEMENTS:
        return 'loadAllOrgAnnouncements';
      case AnnouncementsEndpoint.FETCH_FAVORITED_ORG_ANNOUNCEMENTS:
        return 'favoritedOrgsAnnouncements';
      case AnnouncementsEndpoint.FETCH_OWN_ORG_ANNOUNCEMENTS:
        return 'loadOwnOrgAnnouncements';
      case AnnouncementsEndpoint.FETCH_ANNOUNCEMENT:
        return 'searchForAnnouncement';
      case AnnouncementsEndpoint.ADD_ANNOUNCEMENT:
        return 'createOrgAnnouncement';
      case AnnouncementsEndpoint.EDIT_ANNOUNCEMENT:
        return 'editOrgAnnouncement';
      case AnnouncementsEndpoint.DELETE_ANNOUNCEMENT:
        return 'deleteSingleOrgAnnouncement';
    }
  }
}
