import 'dart:convert';

import 'package:flutter/widgets.dart';

class DefaultErrorResponse {
  final String error;

  const DefaultErrorResponse({
    required this.error,
  });

  factory DefaultErrorResponse.parseJsonOr(String jsonStr, {required DefaultErrorResponse or}) {
    debugPrint(jsonStr);
    try {
      final decodedJson = json.decode(jsonStr);
      return DefaultErrorResponse.fromMap(decodedJson);
    }
    catch(e) {
      return or;
    }
  }
  factory DefaultErrorResponse.fromJson(String jsonStr) => DefaultErrorResponse.fromMap(json.decode(jsonStr));

  factory DefaultErrorResponse.fromMap(Map<String, dynamic> map) {
    return DefaultErrorResponse(
      error: map['error'] as String,
    );
  }
}