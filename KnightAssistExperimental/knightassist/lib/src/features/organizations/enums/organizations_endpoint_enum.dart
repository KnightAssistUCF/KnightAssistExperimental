// ignore_for_file: constant_identifier_names

enum OrganizationsEndpoint {
  FETCH_ALL_ORGANIZATIONS,
  FETCH_ORGANIZATION,
  EDIT_ORGANIZATION,
  DELETE_ORGANIZATION,

  FETCH_FAVORITED_ORGS,
  FETCH_SUGGESTED_ORGS;

  const OrganizationsEndpoint();

  String route() {
    switch (this) {
      case OrganizationsEndpoint.FETCH_ALL_ORGANIZATIONS:
        return 'loadAllOrganizations';
      case OrganizationsEndpoint.FETCH_ORGANIZATION:
        return 'organizationSearch';
      case OrganizationsEndpoint.EDIT_ORGANIZATION:
        return 'editOrganizationProfile';
      case OrganizationsEndpoint.DELETE_ORGANIZATION:
        return 'organizationDelete';
      case OrganizationsEndpoint.FETCH_FAVORITED_ORGS:
        return 'loadFavoritedOrgs';
      case OrganizationsEndpoint.FETCH_SUGGESTED_ORGS:
        return 'getSuggestedOrganizations_ForUser';
    }
  }
}
