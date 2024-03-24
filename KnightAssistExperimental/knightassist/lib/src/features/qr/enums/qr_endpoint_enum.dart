// ignore_for_file: constant_identifier_names

enum QrEndpoint {
  CHECK_IN,
  CHECK_OUT;

  const QrEndpoint();

  static const _baseRoute = '/qr';

  /// Returns the path for qr [endpoint].
  String route() {
    const path = QrEndpoint._baseRoute;
    switch (this) {
      case QrEndpoint.CHECK_IN:
        return 'checkIn_Afterscan';
      case QrEndpoint.CHECK_OUT:
        return 'CheckOut_Afterscan';
    }
  }
}
