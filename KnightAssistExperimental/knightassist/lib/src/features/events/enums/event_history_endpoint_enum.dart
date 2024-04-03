enum EventHistoryEndpoint {
  FETCH_ALL_HISTORY,
  FETCH_HISTORY;

  const EventHistoryEndpoint();

  String route() {
    switch (this) {
      case EventHistoryEndpoint.FETCH_ALL_HISTORY:
        return 'historyOfEvents_User';
      case EventHistoryEndpoint.FETCH_HISTORY:
        return 'historyOfSingleEvent_User';
    }
  }
}
