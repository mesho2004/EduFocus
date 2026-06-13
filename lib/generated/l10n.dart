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
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Hi, Champ!',
      name: 'hiChamp',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Units',
      name: 'units',
      desc: '',
      args: [],
    );
  }

  /// `Lessons`
  String get lessons {
    return Intl.message(
      'Lessons',
      name: 'lessons',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `My Progress`
  String get myProgress {
    return Intl.message(
      'My Progress',
      name: 'myProgress',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Badges',
      name: 'Badges',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'Games Won',
      name: 'gamesWon',
      desc: '',
      args: [],
    );
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
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Log Out`
  String get logOut {
    return Intl.message(
      'Log Out',
      name: 'logOut',
      desc: '',
      args: [],
    );
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

  /// `Parent's Email`
  String get parentEmailLabel {
    return Intl.message(
      'Parent\'s Email',
      name: 'parentEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHint {
    return Intl.message(
      'Email',
      name: 'emailHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHint {
    return Intl.message(
      'Password',
      name: 'passwordHint',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get emailInvalid {
    return Intl.message(
      'Enter a valid email address',
      name: 'emailInvalid',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter your password`
  String get confirmPasswordHint {
    return Intl.message(
      'Re-enter your password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get passwordTooShort {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPasswordRequired {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message(
      'Send Code',
      name: 'sendCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered parent email to receive a password reset code.`
  String get forgotPasswordDescription {
    return Intl.message(
      'Enter your registered parent email to receive a password reset code.',
      name: 'forgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPasswordTitle {
    return Intl.message(
      'Reset Password',
      name: 'resetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter the reset code sent to your email and choose a new password.`
  String get resetPasswordDescription {
    return Intl.message(
      'Enter the reset code sent to your email and choose a new password.',
      name: 'resetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `Reset Code / OTP`
  String get resetCodeLabel {
    return Intl.message(
      'Reset Code / OTP',
      name: 'resetCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter 6-digit code`
  String get resetCodeHint {
    return Intl.message(
      'Enter 6-digit code',
      name: 'resetCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Reset code is required`
  String get resetCodeRequired {
    return Intl.message(
      'Reset code is required',
      name: 'resetCodeRequired',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPasswordLabel {
    return Intl.message(
      'New Password',
      name: 'newPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Choose a new password`
  String get newPasswordHint {
    return Intl.message(
      'Choose a new password',
      name: 'newPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPasswordLabel {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter new password`
  String get confirmNewPasswordHint {
    return Intl.message(
      'Re-enter new password',
      name: 'confirmNewPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Let's set up your profile!`
  String get profileSetupTitle {
    return Intl.message(
      'Let\'s set up your profile!',
      name: 'profileSetupTitle',
      desc: '',
      args: [],
    );
  }

  /// `Type your name here...`
  String get typeYourNameHint {
    return Intl.message(
      'Type your name here...',
      name: 'typeYourNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get enterNameError {
    return Intl.message(
      'Please enter your name',
      name: 'enterNameError',
      desc: '',
      args: [],
    );
  }

  /// `How old are you?`
  String get howOldAreYou {
    return Intl.message(
      'How old are you?',
      name: 'howOldAreYou',
      desc: '',
      args: [],
    );
  }

  /// `Welcome, {name}! Let's start learning! 🚀`
  String welcomeHero(Object name) {
    return Intl.message(
      'Welcome, $name! Let\'s start learning! 🚀',
      name: 'welcomeHero',
      desc: '',
      args: [name],
    );
  }

  /// `Profile updated successfully! ✨`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully! ✨',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Error updating profile: {error} 😢`
  String profileUpdatedError(Object error) {
    return Intl.message(
      'Error updating profile: $error 😢',
      name: 'profileUpdatedError',
      desc: '',
      args: [error],
    );
  }

  /// `Child's Name`
  String get childNameLabel {
    return Intl.message(
      'Child\'s Name',
      name: 'childNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enterNameHint {
    return Intl.message(
      'Enter name',
      name: 'enterNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Name cannot be empty`
  String get nameCannotBeEmpty {
    return Intl.message(
      'Name cannot be empty',
      name: 'nameCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Child's Age`
  String get childAgeLabel {
    return Intl.message(
      'Child\'s Age',
      name: 'childAgeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter age`
  String get enterAgeHint {
    return Intl.message(
      'Enter age',
      name: 'enterAgeHint',
      desc: '',
      args: [],
    );
  }

  /// `Age cannot be empty`
  String get ageCannotBeEmpty {
    return Intl.message(
      'Age cannot be empty',
      name: 'ageCannotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid positive age`
  String get enterValidAge {
    return Intl.message(
      'Enter a valid positive age',
      name: 'enterValidAge',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Choose Face`
  String get chooseFace {
    return Intl.message(
      'Choose Face',
      name: 'chooseFace',
      desc: '',
      args: [],
    );
  }

  /// `Choose Hair`
  String get chooseHair {
    return Intl.message(
      'Choose Hair',
      name: 'chooseHair',
      desc: '',
      args: [],
    );
  }

  /// `Choose Shirt`
  String get chooseShirt {
    return Intl.message(
      'Choose Shirt',
      name: 'chooseShirt',
      desc: '',
      args: [],
    );
  }

  /// `Choose Pants`
  String get choosePants {
    return Intl.message(
      'Choose Pants',
      name: 'choosePants',
      desc: '',
      args: [],
    );
  }

  /// `Choose Hat`
  String get chooseHat {
    return Intl.message(
      'Choose Hat',
      name: 'chooseHat',
      desc: '',
      args: [],
    );
  }

  /// `Face`
  String get faceTab {
    return Intl.message(
      'Face',
      name: 'faceTab',
      desc: '',
      args: [],
    );
  }

  /// `Hair`
  String get hairTab {
    return Intl.message(
      'Hair',
      name: 'hairTab',
      desc: '',
      args: [],
    );
  }

  /// `Shirt`
  String get shirtTab {
    return Intl.message(
      'Shirt',
      name: 'shirtTab',
      desc: '',
      args: [],
    );
  }

  /// `Pants`
  String get pantsTab {
    return Intl.message(
      'Pants',
      name: 'pantsTab',
      desc: '',
      args: [],
    );
  }

  /// `Hat`
  String get hatTab {
    return Intl.message(
      'Hat',
      name: 'hatTab',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Undo`
  String get undo {
    return Intl.message(
      'Undo',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Redo`
  String get redo {
    return Intl.message(
      'Redo',
      name: 'redo',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Piece! 🌟`
  String get unlockPiece {
    return Intl.message(
      'Unlock Piece! 🌟',
      name: 'unlockPiece',
      desc: '',
      args: [],
    );
  }

  /// `Need More Coins! 🪙`
  String get needMoreCoins {
    return Intl.message(
      'Need More Coins! 🪙',
      name: 'needMoreCoins',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to buy this item for {price} coins?`
  String buyConfirmMessage(Object price) {
    return Intl.message(
      'Do you want to buy this item for $price coins?',
      name: 'buyConfirmMessage',
      desc: '',
      args: [price],
    );
  }

  /// `You need {price} coins to buy this, but you only have {userCoins} coins. Play more lessons to earn coins!`
  String notEnoughCoinsMessage(Object price, Object userCoins) {
    return Intl.message(
      'You need $price coins to buy this, but you only have $userCoins coins. Play more lessons to earn coins!',
      name: 'notEnoughCoinsMessage',
      desc: '',
      args: [price, userCoins],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Unlock ({price} 🪙)`
  String unlockButton(Object price) {
    return Intl.message(
      'Unlock ($price 🪙)',
      name: 'unlockButton',
      desc: '',
      args: [price],
    );
  }

  /// `Okay`
  String get okay {
    return Intl.message(
      'Okay',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Successfully unlocked item! 🎉`
  String get unlockSuccess {
    return Intl.message(
      'Successfully unlocked item! 🎉',
      name: 'unlockSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to purchase item: {error}`
  String unlockFailed(Object error) {
    return Intl.message(
      'Failed to purchase item: $error',
      name: 'unlockFailed',
      desc: '',
      args: [error],
    );
  }

  /// `Error loading shop items: {error}`
  String shopLoadError(Object error) {
    return Intl.message(
      'Error loading shop items: $error',
      name: 'shopLoadError',
      desc: '',
      args: [error],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Hi {name}! 👋`
  String hiName(Object name) {
    return Intl.message(
      'Hi $name! 👋',
      name: 'hiName',
      desc: '',
      args: [name],
    );
  }

  /// `Trophy Room`
  String get trophyRoom {
    return Intl.message(
      'Trophy Room',
      name: 'trophyRoom',
      desc: '',
      args: [],
    );
  }

  /// `Streak`
  String get streak {
    return Intl.message(
      'Streak',
      name: 'streak',
      desc: '',
      args: [],
    );
  }

  /// `Coins`
  String get coins {
    return Intl.message(
      'Coins',
      name: 'coins',
      desc: '',
      args: [],
    );
  }

  /// `Completed {completed} of {total} lessons`
  String completedLessonsProgress(Object completed, Object total) {
    return Intl.message(
      'Completed $completed of $total lessons',
      name: 'completedLessonsProgress',
      desc: '',
      args: [completed, total],
    );
  }

  /// `First Win`
  String get trophyFirstWin {
    return Intl.message(
      'First Win',
      name: 'trophyFirstWin',
      desc: '',
      args: [],
    );
  }

  /// `Speedy`
  String get trophySpeedy {
    return Intl.message(
      'Speedy',
      name: 'trophySpeedy',
      desc: '',
      args: [],
    );
  }

  /// `Streak x3`
  String get trophyStreak3 {
    return Intl.message(
      'Streak x3',
      name: 'trophyStreak3',
      desc: '',
      args: [],
    );
  }

  /// `Words`
  String get trophyWords {
    return Intl.message(
      'Words',
      name: 'trophyWords',
      desc: '',
      args: [],
    );
  }

  /// `Numbers`
  String get trophyNumbers {
    return Intl.message(
      'Numbers',
      name: 'trophyNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Master`
  String get trophyMaster {
    return Intl.message(
      'Master',
      name: 'trophyMaster',
      desc: '',
      args: [],
    );
  }

  /// `Hi Champ! 🚀`
  String get onboardingHiChampTitle {
    return Intl.message(
      'Hi Champ! 🚀',
      name: 'onboardingHiChampTitle',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to EduFocus! We're super excited to have you here. Let's start a fun learning adventure together!`
  String get onboardingHiChampDesc {
    return Intl.message(
      'Welcome to EduFocus! We\'re super excited to have you here. Let\'s start a fun learning adventure together!',
      name: 'onboardingHiChampDesc',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Subject 📚`
  String get onboardingSubjectTitle {
    return Intl.message(
      'Choose a Subject 📚',
      name: 'onboardingSubjectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select from English, Math, Arabic, and more. Tap on any subject to see all its units and lessons!`
  String get onboardingSubjectDesc {
    return Intl.message(
      'Select from English, Math, Arabic, and more. Tap on any subject to see all its units and lessons!',
      name: 'onboardingSubjectDesc',
      desc: '',
      args: [],
    );
  }

  /// `Play Fun Games 🎮`
  String get onboardingGamesTitle {
    return Intl.message(
      'Play Fun Games 🎮',
      name: 'onboardingGamesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Complete your path by playing games like bubble popping, word matching, letter connecting, and sound puzzles!`
  String get onboardingGamesDesc {
    return Intl.message(
      'Complete your path by playing games like bubble popping, word matching, letter connecting, and sound puzzles!',
      name: 'onboardingGamesDesc',
      desc: '',
      args: [],
    );
  }

  /// `Stars & Customization 🪙`
  String get onboardingStarsTitle {
    return Intl.message(
      'Stars & Customization 🪙',
      name: 'onboardingStarsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Earn stars to purchase cool outfits for your custom Lego character. You can also enable eye-tracking in your profile!`
  String get onboardingStarsDesc {
    return Intl.message(
      'Earn stars to purchase cool outfits for your custom Lego character. You can also enable eye-tracking in your profile!',
      name: 'onboardingStarsDesc',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Let's Play! 🚀`
  String get letsPlay {
    return Intl.message(
      'Let\'s Play! 🚀',
      name: 'letsPlay',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get darkMode {
    return Intl.message(
      'Dark mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `First Word`
  String get badgeFirstWord {
    return Intl.message(
      'First Word',
      name: 'badgeFirstWord',
      desc: '',
      args: [],
    );
  }

  /// `Perfect Score`
  String get badgePerfectScore {
    return Intl.message(
      'Perfect Score',
      name: 'badgePerfectScore',
      desc: '',
      args: [],
    );
  }

  /// `3 Day Streak`
  String get badgeStreak3 {
    return Intl.message(
      '3 Day Streak',
      name: 'badgeStreak3',
      desc: '',
      args: [],
    );
  }

  /// `Puzzle Master`
  String get badgePuzzleMaster {
    return Intl.message(
      'Puzzle Master',
      name: 'badgePuzzleMaster',
      desc: '',
      args: [],
    );
  }

  /// `Age: {age}`
  String profileUserAge(Object age) {
    return Intl.message(
      'Age: $age',
      name: 'profileUserAge',
      desc: '',
      args: [age],
    );
  }

  /// `Letter Hero`
  String get profileHeroTitle {
    return Intl.message(
      'Letter Hero',
      name: 'profileHeroTitle',
      desc: '',
      args: [],
    );
  }

  /// `{days} Days`
  String streakDaysValue(Object days) {
    return Intl.message(
      '$days Days',
      name: 'streakDaysValue',
      desc: '',
      args: [days],
    );
  }

  /// `Sentences`
  String get sentencesUnit {
    return Intl.message(
      'Sentences',
      name: 'sentencesUnit',
      desc: '',
      args: [],
    );
  }

  /// `Words II`
  String get wordsUnit2 {
    return Intl.message(
      'Words II',
      name: 'wordsUnit2',
      desc: '',
      args: [],
    );
  }

  /// `Words I`
  String get wordsUnit1 {
    return Intl.message(
      'Words I',
      name: 'wordsUnit1',
      desc: '',
      args: [],
    );
  }

  /// `Letters II`
  String get lettersUnit2 {
    return Intl.message(
      'Letters II',
      name: 'lettersUnit2',
      desc: '',
      args: [],
    );
  }

  /// `Letters I`
  String get lettersUnit1 {
    return Intl.message(
      'Letters I',
      name: 'lettersUnit1',
      desc: '',
      args: [],
    );
  }

  /// `Supermarket`
  String get supermarketTitle {
    return Intl.message(
      'Supermarket',
      name: 'supermarketTitle',
      desc: '',
      args: [],
    );
  }

  /// `Continue your shopping adventure!`
  String get supermarketDesc {
    return Intl.message(
      'Continue your shopping adventure!',
      name: 'supermarketDesc',
      desc: '',
      args: [],
    );
  }

  /// `Play Again`
  String get playAgain {
    return Intl.message(
      'Play Again',
      name: 'playAgain',
      desc: '',
      args: [],
    );
  }

  /// `Learning that feels like playing.`
  String get splashSubTitle {
    return Intl.message(
      'Learning that feels like playing.',
      name: 'splashSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get homeTab {
    return Intl.message(
      'Home',
      name: 'homeTab',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progressTab {
    return Intl.message(
      'Progress',
      name: 'progressTab',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profileTab {
    return Intl.message(
      'Profile',
      name: 'profileTab',
      desc: '',
      args: [],
    );
  }

  /// `EduFocus Reset Code`
  String get resetCodeNotificationTitle {
    return Intl.message(
      'EduFocus Reset Code',
      name: 'resetCodeNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your reset code is: {code}`
  String resetCodeNotificationBody(Object code) {
    return Intl.message(
      'Your reset code is: $code',
      name: 'resetCodeNotificationBody',
      desc: '',
      args: [code],
    );
  }

  /// `{completed} / {total} Lessons ({pct}%)`
  String lessonsCount(Object completed, Object total, Object pct) {
    return Intl.message(
      '$completed / $total Lessons ($pct%)',
      name: 'lessonsCount',
      desc: '',
      args: [completed, total, pct],
    );
  }

  /// `Complete the previous unit first`
  String get completePrevUnitFirst {
    return Intl.message(
      'Complete the previous unit first',
      name: 'completePrevUnitFirst',
      desc: '',
      args: [],
    );
  }

  /// `{completed} / {total} Lessons`
  String lessonsFraction(Object completed, Object total) {
    return Intl.message(
      '$completed / $total Lessons',
      name: 'lessonsFraction',
      desc: '',
      args: [completed, total],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Great job! You finished {unitTitle}!`
  String finishedUnit(Object unitTitle) {
    return Intl.message(
      'Great job! You finished $unitTitle!',
      name: 'finishedUnit',
      desc: '',
      args: [unitTitle],
    );
  }

  /// `All Units Conquered! Score: {score}`
  String allUnitsConquered(Object score) {
    return Intl.message(
      'All Units Conquered! Score: $score',
      name: 'allUnitsConquered',
      desc: '',
      args: [score],
    );
  }

  /// `{unitTitle} Completed!`
  String unitCompleted(Object unitTitle) {
    return Intl.message(
      '$unitTitle Completed!',
      name: 'unitCompleted',
      desc: '',
      args: [unitTitle],
    );
  }

  /// `Amazing progress!\nTotal Score: {score}`
  String amazingProgress(Object score) {
    return Intl.message(
      'Amazing progress!\nTotal Score: $score',
      name: 'amazingProgress',
      desc: '',
      args: [score],
    );
  }

  /// `Next Unit`
  String get nextUnit {
    return Intl.message(
      'Next Unit',
      name: 'nextUnit',
      desc: '',
      args: [],
    );
  }

  /// `Lesson {current} / {total}`
  String lessonFractionPrefix(Object current, Object total) {
    return Intl.message(
      'Lesson $current / $total',
      name: 'lessonFractionPrefix',
      desc: '',
      args: [current, total],
    );
  }

  /// `Lesson Complete!`
  String get lessonComplete {
    return Intl.message(
      'Lesson Complete!',
      name: 'lessonComplete',
      desc: '',
      args: [],
    );
  }

  /// `Try Again!`
  String get tryAgain {
    return Intl.message(
      'Try Again!',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Score: {score} / {total}`
  String lessonScore(Object score, Object total) {
    return Intl.message(
      'Score: $score / $total',
      name: 'lessonScore',
      desc: '',
      args: [score, total],
    );
  }

  /// `You need at least 2 stars to pass.`
  String get needTwoStars {
    return Intl.message(
      'You need at least 2 stars to pass.',
      name: 'needTwoStars',
      desc: '',
      args: [],
    );
  }

  /// `➡️  Next Lesson`
  String get nextLesson {
    return Intl.message(
      '➡️  Next Lesson',
      name: 'nextLesson',
      desc: '',
      args: [],
    );
  }

  /// `🔄  Try Again`
  String get tryAgainBtn {
    return Intl.message(
      '🔄  Try Again',
      name: 'tryAgainBtn',
      desc: '',
      args: [],
    );
  }

  /// `Back to Lessons →`
  String get backToLessons {
    return Intl.message(
      'Back to Lessons →',
      name: 'backToLessons',
      desc: '',
      args: [],
    );
  }

  /// `Excellent! Well done!`
  String get ttsPraise {
    return Intl.message(
      'Excellent! Well done!',
      name: 'ttsPraise',
      desc: '',
      args: [],
    );
  }

  /// `Try again! You can do it!`
  String get ttsTryAgain {
    return Intl.message(
      'Try again! You can do it!',
      name: 'ttsTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Try again to get at least 2 stars and pass!`
  String get ttsFailed {
    return Intl.message(
      'Try again to get at least 2 stars and pass!',
      name: 'ttsFailed',
      desc: '',
      args: [],
    );
  }

  /// `Amazing! You finished the lesson with {stars} stars!`
  String ttsCompleted(Object stars) {
    return Intl.message(
      'Amazing! You finished the lesson with $stars stars!',
      name: 'ttsCompleted',
      desc: '',
      args: [stars],
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
