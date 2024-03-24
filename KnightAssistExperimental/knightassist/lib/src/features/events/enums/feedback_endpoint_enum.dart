// ignore_for_file: constant_identifier_names

enum FeedbackEndpoint {
  FETCH_ORG_FEEDBACK,
  ADD_FEEDBACK,
  SET_READ;

  const FeedbackEndpoint();

  String route() {
    switch (this) {
      case FeedbackEndpoint.FETCH_ORG_FEEDBACK:
        return 'retrieveAllFeedback_ForAnOrg';
      case FeedbackEndpoint.ADD_FEEDBACK:
        return 'addFeedback';
      case FeedbackEndpoint.SET_READ:
        return 'markAsRead';
    }
  }
}
