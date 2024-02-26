import 'package:flutter/material.dart';

@immutable
class ApiEndpoint {
  const ApiEndpoint._();

  static const baseUrl = String.fromEnvironment('BASE_URL',
      defaultValue: 'https://knightassist-43ab3aeaada9.herokuapp.com/api');

  // TODO: Set up endpoints
}
