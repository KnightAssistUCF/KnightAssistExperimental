// ignore_for_file: constant_identifier_names

enum AuthEndpoint {
  REGISTER_VOLUNTEER,
  REGISTER_ORGANIZATION,
  LOGIN,
  REFRESH_TOKEN,
  FORGOT_PASSWORD;

  const AuthEndpoint();

  String route() {
    switch (this) {
      case AuthEndpoint.REGISTER_VOLUNTEER:
        return 'userSignUp';
      case AuthEndpoint.REGISTER_ORGANIZATION:
        return 'organizationSignUp';
      case AuthEndpoint.LOGIN:
        return 'Login';
      case AuthEndpoint.REFRESH_TOKEN:
        return 'refreshJWT';
      case AuthEndpoint.FORGOT_PASSWORD:
        return 'forgotPassword';
    }
  }
}
