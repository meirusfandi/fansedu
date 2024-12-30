import 'package:fansedu/generated/l10n.dart';
import 'package:flutter/material.dart';

class Error {
  static String networkParse(int statusCode) {
    switch (statusCode) {
      case 500:
      case 501:
      case 502:
      case 503:
        return 'Service tidak tersedia';
      default:
        return 'Server bermasalah';
    }
  }

  static String parseMessageCode({
    required BuildContext ctx,
    required String? defaultMessage,
    required String? messageCode,
    required String? statusCode,
  }) {
    if (statusCode?.startsWith('5') ?? false) {
      return S.of(ctx).general_error;
    } else if (statusCode?.startsWith('6') ?? false) {
      return S.of(ctx).general_error;
    } else {
      switch (messageCode) {
        case 'RME00':
        default:
          return defaultMessage ?? S.of(ctx).general_error;
      }
    }
  }
}
