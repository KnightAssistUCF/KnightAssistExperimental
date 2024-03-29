// ignore_for_file: constant_identifier_names

enum QrEndpoint {
  CHECK_IN,
  CHECK_OUT;

  const QrEndpoint();

  /// Returns the path for qr [endpoint].
  String route() {
    switch (this) {
      case QrEndpoint.CHECK_IN:
        return 'checkIn_Afterscan';
      case QrEndpoint.CHECK_OUT:
        return 'CheckOut_Afterscan';
    }
  }
}
