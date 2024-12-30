// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Save`
  String get general_save {
    return Intl.message(
      'Save',
      name: 'general_save',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get general_error {
    return Intl.message(
      'Something Went Wrong',
      name: 'general_error',
      desc: '',
      args: [],
    );
  }

  /// `Oke`
  String get general_oke_button {
    return Intl.message(
      'Oke',
      name: 'general_oke_button',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get general_close {
    return Intl.message(
      'Close',
      name: 'general_close',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get general_coming_soon {
    return Intl.message(
      'Coming Soon',
      name: 'general_coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get general_confirm {
    return Intl.message(
      'Confirmation',
      name: 'general_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get general_yes {
    return Intl.message(
      'Yes',
      name: 'general_yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get general_no {
    return Intl.message(
      'No',
      name: 'general_no',
      desc: '',
      args: [],
    );
  }

  /// `Give Access`
  String get button_permission {
    return Intl.message(
      'Give Access',
      name: 'button_permission',
      desc: '',
      args: [],
    );
  }

  /// `Reject Access`
  String get button_reject_access {
    return Intl.message(
      'Reject Access',
      name: 'button_reject_access',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
