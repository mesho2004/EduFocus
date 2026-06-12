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
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Parent Portal`
  String get parentPortal {
    return Intl.message(
      'Parent Portal',
      name: 'parentPortal',
      desc: '',
      args: [],
    );
  }

  /// `Sign in to set up a safe learning environment for your hero.`
  String get parentPortalDescription {
    return Intl.message(
      'Sign in to set up a safe learning environment for your hero.',
      name: 'parentPortalDescription',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Once signed in, the child's world begins.This screen will not appear again.`
  String get parentPortalFooter {
    return Intl.message(
      'Once signed in, the child\'s world begins.This screen will not appear again.',
      name: 'parentPortalFooter',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `New Explorer`
  String get newExplorer {
    return Intl.message(
      'New Explorer',
      name: 'newExplorer',
      desc: '',
      args: [],
    );
  }

  /// `What is your hero's name?`
  String get heroName {
    return Intl.message(
      'What is your hero\'s name?',
      name: 'heroName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your hero's name`
  String get heroNameHint {
    return Intl.message(
      'Enter your hero\'s name',
      name: 'heroNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your hero's name`
  String get heroNameError {
    return Intl.message(
      'Please enter your hero\'s name',
      name: 'heroNameError',
      desc: '',
      args: [],
    );
  }

  /// `How old is your hero?`
  String get heroAge {
    return Intl.message(
      'How old is your hero?',
      name: 'heroAge',
      desc: '',
      args: [],
    );
  }

  /// `Start Learning`
  String get startLearning {
    return Intl.message(
      'Start Learning',
      name: 'startLearning',
      desc: '',
      args: [],
    );
  }

  /// `Parents: You can change these later in settings`
  String get heroFooter {
    return Intl.message(
      'Parents: You can change these later in settings',
      name: 'heroFooter',
      desc: '',
      args: [],
    );
  }

  /// `Hi, Champ!`
  String get hiChamp {
    return Intl.message('Hi, Champ!', name: 'hiChamp', desc: '', args: []);
  }

  /// `Choose your subject and start playing!`
  String get homeDescription {
    return Intl.message(
      'Choose your subject and start playing!',
      name: 'homeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Overall Progress`
  String get overallProgress {
    return Intl.message(
      'Overall Progress',
      name: 'overallProgress',
      desc: '',
      args: [],
    );
  }

  /// `Let's start playing!`
  String get letsStartPlaying {
    return Intl.message(
      'Let\'s start playing!',
      name: 'letsStartPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Units`
  String get units {
    return Intl.message('Units', name: 'units', desc: '', args: []);
  }

  /// `Lessons`
  String get lessons {
    return Intl.message('Lessons', name: 'lessons', desc: '', args: []);
  }

  /// `Completed`
  String get completed {
    return Intl.message('Completed', name: 'completed', desc: '', args: []);
  }

  /// `My Progress`
  String get myProgress {
    return Intl.message('My Progress', name: 'myProgress', desc: '', args: []);
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message('My Profile', name: 'myProfile', desc: '', args: []);
  }

  /// `Achievements & Rewards`
  String get AchievementsRewards {
    return Intl.message(
      'Achievements & Rewards',
      name: 'AchievementsRewards',
      desc: '',
      args: [],
    );
  }

  /// `Badges`
  String get Badges {
    return Intl.message('Badges', name: 'Badges', desc: '', args: []);
  }

  /// `Total Points`
  String get totalPoints {
    return Intl.message(
      'Total Points',
      name: 'totalPoints',
      desc: '',
      args: [],
    );
  }

  /// `Games Won`
  String get gamesWon {
    return Intl.message('Games Won', name: 'gamesWon', desc: '', args: []);
  }

  /// `Adaptive Settings`
  String get adaptiveSettings {
    return Intl.message(
      'Adaptive Settings',
      name: 'adaptiveSettings',
      desc: '',
      args: [],
    );
  }

  /// `Eye-Tracking mode`
  String get eyeMode {
    return Intl.message(
      'Eye-Tracking mode',
      name: 'eyeMode',
      desc: '',
      args: [],
    );
  }

  /// `Enable eye-tracking mode`
  String get eyeModeDescription {
    return Intl.message(
      'Enable eye-tracking mode',
      name: 'eyeModeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Text & Icon Size`
  String get textIconSize {
    return Intl.message(
      'Text & Icon Size',
      name: 'textIconSize',
      desc: '',
      args: [],
    );
  }

  /// `Adjust for better visibility`
  String get textIconSizeDescription {
    return Intl.message(
      'Adjust for better visibility',
      name: 'textIconSizeDescription',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get AccountSettings {
    return Intl.message(
      'Account Settings',
      name: 'AccountSettings',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get changeLanguage {
    return Intl.message(
      'Change Language',
      name: 'changeLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message('English', name: 'English', desc: '', args: []);
  }

  /// `Log Out`
  String get logOut {
    return Intl.message('Log Out', name: 'logOut', desc: '', args: []);
  }

  /// `Sorry, this lesson is not available yet. Please check back later.`
  String get lessonNotFound {
    return Intl.message(
      'Sorry, this lesson is not available yet. Please check back later.',
      name: 'lessonNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there was an error loading this lesson. Please try again later.`
  String get lessonErrorLoading {
    return Intl.message(
      'Sorry, there was an error loading this lesson. Please try again later.',
      name: 'lessonErrorLoading',
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
      Locale.fromSubtags(languageCode: 'ar'),
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
