// ignore_for_file: constant_identifier_names

enum EventsEndpoint {
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
  REMOVE_RSVP;

  const EventsEndpoint();

  /// Returns the path for events [endpoint].
  String route() {
    switch (this) {
      case EventsEndpoint.FETCH_ALL_EVENTS:
        return 'loadAllEventsAcrossOrgs';
      case EventsEndpoint.FETCH_EVENT:
        return 'searchOneEvent';
      case EventsEndpoint.ADD_EVENT:
        return 'addEvent';
      case EventsEndpoint.EDIT_EVENT:
        return 'editEvent';
      case EventsEndpoint.DELETE_EVENT:
        return 'deleteSingleEvent';
      case EventsEndpoint.FETCH_ORG_EVENTS:
        return 'searchEvent';
      case EventsEndpoint.FETCH_RSVPED_EVENTS:
        return 'searchUserRSVPedEvents';
      case EventsEndpoint.ADD_RSVP:
        return 'RSVPForEvent';
      case EventsEndpoint.REMOVE_RSVP:
        return 'cancelRSVP';
      case EventsEndpoint.FETCH_FAVORITED_ORGS_EVENTS:
        return 'loadFavoritedOrgsEvents';
      case EventsEndpoint.FETCH_SUGGESTED_EVENTS:
        return 'getSuggestedEvents_ForUser';
    }
  }
}
