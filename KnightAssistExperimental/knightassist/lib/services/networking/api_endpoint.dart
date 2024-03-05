import 'package:flutter/material.dart';

// TODO: EVENT HISTORY ENDPOINTS, VOLUNTEER HOUR GOAL, TAGS

@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  static const baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'https://knightassist-43ab3aeaada9.herokuapp.com/api/');

  static String auth(AuthEndpoint endpoint) {
    switch (endpoint) {
      case AuthEndpoint.REGISTER_VOLUNTEER:
        return '/userSignUp';
      case AuthEndpoint.REGISTER_ORGANIZATION:
        return '/organizationSignUp';
      case AuthEndpoint.LOGIN:
        return '/Login';
      case AuthEndpoint.FORGOT_PASSWORD:
        return '/forgotPassword';
    }
  }

  static String volunteers(VolunteerEndpoint endpoint) {
    switch (endpoint) {
      case VolunteerEndpoint.FETCH_VOLUNTEER:
        return 'searchUser';
      case VolunteerEndpoint.EDIT_VOLUNTEER:
        return 'editUserProfile';
      case VolunteerEndpoint.DELETE_VOLUNTEER:
        return 'userDelete';
      case VolunteerEndpoint.ADD_FAVORITE_ORG:
        return 'addFavoriteOrg';
      case VolunteerEndpoint.REMOVE_FAVORITE_ORG:
        return 'removeFavoriteOrg';
      case VolunteerEndpoint.FETCH_VOLUNTEERS_IN_ORG:
        return 'loadAllStudentsInOrganization';
      case VolunteerEndpoint.FETCH_EVENT_ATTENDEES:
        return 'loadAllEventAttendees';
      case VolunteerEndpoint.FETCH_LEADERBOARD:
        return 'allStudentsRanking';
      case VolunteerEndpoint.FETCH_ORG_LEADERBOARD:
        return 'perOrgLeaderboard';
    }
  }

  static String organizations(OrganizationEndpoint endpoint) {
    switch (endpoint) {
      case OrganizationEndpoint.FETCH_ALL_ORGANIZATIONS:
        return 'loadAllOrganizations';
      case OrganizationEndpoint.FETCH_ORGANIZATION:
        return 'organizationSearch';
      case OrganizationEndpoint.EDIT_ORGANIZATION:
        return 'editOrganizationProfile';
      case OrganizationEndpoint.DELETE_ORGANIZATION:
        return 'organizationDelete';
      case OrganizationEndpoint.FETCH_FAVORITED_ORGS:
        return 'loadFavoritedOrgs';
      case OrganizationEndpoint.FETCH_SUGGESTED_ORGS:
        return 'getSuggestedOrganizations_ForUser';
    }
  }

  static String events(EventEndpoint endpoint) {
    switch (endpoint) {
      case EventEndpoint.FETCH_ALL_EVENTS:
        return 'loadAllEventsAcrossOrgs';
      case EventEndpoint.FETCH_EVENT:
        return 'searchOneEvent';
      case EventEndpoint.ADD_EVENT:
        return 'addEvent';
      case EventEndpoint.EDIT_EVENT:
        return 'editEvent';
      case EventEndpoint.DELETE_EVENT:
        return 'deleteSingleEvent';
      case EventEndpoint.FETCH_ORG_EVENTS:
        return 'searchAllEventsOfAnOrg';
      case EventEndpoint.FETCH_RSVPED_EVENTS:
        return 'searchUserRSVPedEvents';
      case EventEndpoint.ADD_RSVP:
        return 'RSVPForEvent';
      case EventEndpoint.REMOVE_RSVP:
        return 'cancelRSVP';
      case EventEndpoint.FETCH_FAVORITED_ORGS_EVENTS:
        return 'loadFavoritedOrgsEvents';
      case EventEndpoint.FETCH_SUGGESTED_EVENTS:
        return 'getSuggestedEvents_ForUser';
    }
  }

  static String announcements(AnnouncementEndpoint endpoint) {
    switch (endpoint) {
      case AnnouncementEndpoint.FETCH_ALL_ANNOUNCEMENTS:
        return 'loadAllOrgAnnouncements';
      case AnnouncementEndpoint.FETCH_FAVORITED_ORG_ANNOUNCEMENTS:
        return 'favoritedOrgsAnnouncements';
      case AnnouncementEndpoint.FETCH_ANNOUNCEMENT:
        return 'searchForAnnouncement';
      case AnnouncementEndpoint.ADD_ANNOUNCEMENT:
        return 'createOrgAnnouncement';
      case AnnouncementEndpoint.EDIT_ANNOUNCEMENT:
        return 'editOrgAnnouncement';
      case AnnouncementEndpoint.DELETE_ANNOUNCEMENT:
        return 'deleteSingleOrgAnnouncement';
    }
  }

  static String feedback(FeedbackEndpoint endpoint) {
    switch (endpoint) {
      case FeedbackEndpoint.FETCH_ORG_FEEDBACK:
        return 'retrieveAllFeedback_ForAnOrg';
      case FeedbackEndpoint.ADD_FEEDBACK:
        return 'addFeedback';
      case FeedbackEndpoint.SET_READ:
        return 'markAsRead';
    }
  }

  static String images(ImageEndpoint endpoint) {
    switch (endpoint) {
      case ImageEndpoint.FETCH_IMAGE:
        return 'retrieveImage';
      case ImageEndpoint.STORE_IMAGE:
        return 'storeImage';
      case ImageEndpoint.DELETE_IMAGE:
        return 'deleteImage';
    }
  }

  static String qr(QREndpoint endpoint) {
    switch (endpoint) {
      case QREndpoint.CHECK_IN:
        return 'checkIn_Afterscan';
      case QREndpoint.CHECK_OUT:
        return 'CheckOut_Afterscan';
    }
  }

  static String notifications(NotificationEndpoint endpoint) {
    switch (endpoint) {
      case NotificationEndpoint.FETCH_NOTIFICATIONS:
        return 'pushNotifications';
      case NotificationEndpoint.FETCH_READ_STATUS:
        return 'readStatus';
      case NotificationEndpoint.SET_READ:
        return 'markNotificationAsRead';
    }
  }
}

enum AuthEndpoint {
  REGISTER_VOLUNTEER,
  REGISTER_ORGANIZATION,
  LOGIN,
  // REFRESH_TOKEN,
  FORGOT_PASSWORD,
  // RESET_PASSWORD,
  // CHANGE_PASSWORD,
  // VERIFY_OTP,
}

enum VolunteerEndpoint {
  FETCH_VOLUNTEER,
  EDIT_VOLUNTEER,
  DELETE_VOLUNTEER,

  FETCH_VOLUNTEERS_IN_ORG,
  FETCH_EVENT_ATTENDEES,

  FETCH_LEADERBOARD,
  FETCH_ORG_LEADERBOARD,

  ADD_FAVORITE_ORG,
  REMOVE_FAVORITE_ORG,
}

enum OrganizationEndpoint {
  FETCH_ALL_ORGANIZATIONS,
  FETCH_ORGANIZATION,
  EDIT_ORGANIZATION,
  DELETE_ORGANIZATION,

  FETCH_FAVORITED_ORGS,
  FETCH_SUGGESTED_ORGS,
}

enum EventEndpoint {
  FETCH_ALL_EVENTS,
  FETCH_EVENT,
  ADD_EVENT,
  EDIT_EVENT,
  DELETE_EVENT,

  FETCH_ORG_EVENTS,
  FETCH_RSVPED_EVENTS,
  FETCH_FAVORITED_ORGS_EVENTS,
  FETCH_SUGGESTED_EVENTS,

  ADD_RSVP,
  REMOVE_RSVP,
}

enum FeedbackEndpoint {
  FETCH_ORG_FEEDBACK,
  ADD_FEEDBACK,
  SET_READ,
}

enum AnnouncementEndpoint {
  FETCH_ALL_ANNOUNCEMENTS,
  FETCH_FAVORITED_ORG_ANNOUNCEMENTS,
  FETCH_ANNOUNCEMENT,
  ADD_ANNOUNCEMENT,
  EDIT_ANNOUNCEMENT,
  DELETE_ANNOUNCEMENT,
}

enum ImageEndpoint {
  FETCH_IMAGE,
  STORE_IMAGE,
  DELETE_IMAGE,
}

enum QREndpoint {
  CHECK_IN,
  CHECK_OUT,
}

enum NotificationEndpoint {
  FETCH_NOTIFICATIONS,
  FETCH_READ_STATUS,
  SET_READ,
}
