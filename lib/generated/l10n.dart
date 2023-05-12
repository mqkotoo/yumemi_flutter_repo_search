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

  /// `GitHub Search`
  String get searchPageTitle {
    return Intl.message(
      'GitHub Search',
      name: 'searchPageTitle',
      desc: '',
      args: [],
    );
  }

  /// ` results`
  String get result {
    return Intl.message(
      ' results',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Repo Detail`
  String get detailPageTitle {
    return Intl.message(
      'Repo Detail',
      name: 'detailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search Repository`
  String get formHintText {
    return Intl.message(
      'Search Repository',
      name: 'formHintText',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Star`
  String get star {
    return Intl.message(
      'Star',
      name: 'star',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get watch {
    return Intl.message(
      'Watch',
      name: 'watch',
      desc: '',
      args: [],
    );
  }

  /// `Fork`
  String get fork {
    return Intl.message(
      'Fork',
      name: 'fork',
      desc: '',
      args: [],
    );
  }

  /// `Issue`
  String get issue {
    return Intl.message(
      'Issue',
      name: 'issue',
      desc: '',
      args: [],
    );
  }

  /// `View On GitHub`
  String get viewOnGitHub {
    return Intl.message(
      'View On GitHub',
      name: 'viewOnGitHub',
      desc: '',
      args: [],
    );
  }

  /// `Error Occurred.`
  String get errorOccurred {
    return Intl.message(
      'Error Occurred.',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Please retry later.`
  String get errorOccurredDetail {
    return Intl.message(
      'Please retry later.',
      name: 'errorOccurredDetail',
      desc: '',
      args: [],
    );
  }

  /// `Network Error.`
  String get networkError {
    return Intl.message(
      'Network Error.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Please check the connection and try again.`
  String get networkErrorDetail {
    return Intl.message(
      'Please check the connection and try again.',
      name: 'networkErrorDetail',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Text.`
  String get enterText {
    return Intl.message(
      'Please Enter Text.',
      name: 'enterText',
      desc: '',
      args: [],
    );
  }

  /// `Not Found Search Result.`
  String get noResult {
    return Intl.message(
      'Not Found Search Result.',
      name: 'noResult',
      desc: '',
      args: [],
    );
  }

  /// `Please change your search words.`
  String get noResultDetail {
    return Intl.message(
      'Please change your search words.',
      name: 'noResultDetail',
      desc: '',
      args: [],
    );
  }

  /// `Best Match`
  String get bestMatch {
    return Intl.message(
      'Best Match',
      name: 'bestMatch',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get updated {
    return Intl.message(
      'Updated',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `Stars`
  String get stars {
    return Intl.message(
      'Stars',
      name: 'stars',
      desc: '',
      args: [],
    );
  }

  /// `Forks`
  String get forks {
    return Intl.message(
      'Forks',
      name: 'forks',
      desc: '',
      args: [],
    );
  }

  /// `Help Wanted Issues`
  String get helpWantedIssue {
    return Intl.message(
      'Help Wanted Issues',
      name: 'helpWantedIssue',
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
      Locale.fromSubtags(languageCode: 'ja'),
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
