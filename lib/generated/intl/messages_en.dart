// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(price) => "Do you want to buy this item for ${price} coins?";

  static String m1(completed, total) =>
      "Completed ${completed} of ${total} lessons";

  static String m2(name) => "Hi ${name}! 👋";

  static String m3(price, userCoins) =>
      "You need ${price} coins to buy this, but you only have ${userCoins} coins. Play more lessons to earn coins!";

  static String m4(error) => "Error updating profile: ${error} 😢";

  static String m5(error) => "Error loading shop items: ${error}";

  static String m6(price) => "Unlock (${price} 🪙)";

  static String m7(error) => "Failed to purchase item: ${error}";

  static String m8(name) => "Welcome, ${name}! Let\'s start learning! 🚀";

  static String m9(age) => "Age: ${age}";

  static String m10(days) => "${days} Days";

  static String m11(code) => "Your reset code is: ${code}";

  static String m12(completed, total, pct) =>
      "${completed} / ${total} Lessons (${pct}%)";

  static String m13(completed, total) => "${completed} / ${total} Lessons";

  static String m14(unitTitle) => "Great job! You finished ${unitTitle}!";

  static String m15(score) => "All Units Conquered! Score: ${score}";

  static String m16(unitTitle) => "${unitTitle} Completed!";

  static String m17(score) => "Amazing progress!\nTotal Score: ${score}";

  static String m18(current, total) => "Lesson ${current} / ${total}";

  static String m19(score, total) => "Score: ${score} / ${total}";

  static String m20(stars) => "Amazing! You finished the lesson with ${stars} stars!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AccountSettings":
            MessageLookupByLibrary.simpleMessage("Account Settings"),
        "AchievementsRewards":
            MessageLookupByLibrary.simpleMessage("Achievements & Rewards"),
        "Badges": MessageLookupByLibrary.simpleMessage("Badges"),
        "English": MessageLookupByLibrary.simpleMessage("English"),
        "adaptiveSettings":
            MessageLookupByLibrary.simpleMessage("Adaptive Settings"),
        "ageCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Age cannot be empty"),
        "buyConfirmMessage": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeLanguage":
            MessageLookupByLibrary.simpleMessage("Change Language"),
        "childAgeLabel": MessageLookupByLibrary.simpleMessage("Child\'s Age"),
        "childNameLabel": MessageLookupByLibrary.simpleMessage("Child\'s Name"),
        "chooseFace": MessageLookupByLibrary.simpleMessage("Choose Face"),
        "chooseHair": MessageLookupByLibrary.simpleMessage("Choose Hair"),
        "chooseHat": MessageLookupByLibrary.simpleMessage("Choose Hat"),
        "choosePants": MessageLookupByLibrary.simpleMessage("Choose Pants"),
        "chooseShirt": MessageLookupByLibrary.simpleMessage("Choose Shirt"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "completedLessonsProgress": m1,
        "confirmNewPasswordHint":
            MessageLookupByLibrary.simpleMessage("Re-enter new password"),
        "confirmNewPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("Re-enter your password"),
        "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
            "Please confirm your password"),
        "createAccount": MessageLookupByLibrary.simpleMessage("Create Account"),
        "darkMode": MessageLookupByLibrary.simpleMessage("Dark mode"),
        "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
        "email": MessageLookupByLibrary.simpleMessage("Email"),
        "emailHint": MessageLookupByLibrary.simpleMessage("Email"),
        "emailInvalid":
            MessageLookupByLibrary.simpleMessage("Enter a valid email address"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("Email is required"),
        "enterAgeHint": MessageLookupByLibrary.simpleMessage("Enter age"),
        "enterNameError":
            MessageLookupByLibrary.simpleMessage("Please enter your name"),
        "enterNameHint": MessageLookupByLibrary.simpleMessage("Enter name"),
        "enterValidAge":
            MessageLookupByLibrary.simpleMessage("Enter a valid positive age"),
        "eyeMode": MessageLookupByLibrary.simpleMessage("Eye-Tracking mode"),
        "eyeModeDescription":
            MessageLookupByLibrary.simpleMessage("Enable eye-tracking mode"),
        "faceTab": MessageLookupByLibrary.simpleMessage("Face"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("Forgot Password?"),
        "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
            "Enter your registered parent email to receive a password reset code."),
        "gamesWon": MessageLookupByLibrary.simpleMessage("Games Won"),
        "hairTab": MessageLookupByLibrary.simpleMessage("Hair"),
        "hatTab": MessageLookupByLibrary.simpleMessage("Hat"),
        "heroAge":
            MessageLookupByLibrary.simpleMessage("How old is your hero?"),
        "heroFooter": MessageLookupByLibrary.simpleMessage(
            "Parents: You can change these later in settings"),
        "heroName":
            MessageLookupByLibrary.simpleMessage("What is your hero\'s name?"),
        "heroNameError": MessageLookupByLibrary.simpleMessage(
            "Please enter your hero\'s name"),
        "heroNameHint":
            MessageLookupByLibrary.simpleMessage("Enter your hero\'s name"),
        "hiChamp": MessageLookupByLibrary.simpleMessage("Hi, Champ!"),
        "hiName": m2,
        "homeDescription": MessageLookupByLibrary.simpleMessage(
            "Choose your subject and start playing!"),
        "howOldAreYou":
            MessageLookupByLibrary.simpleMessage("How old are you?"),
        "lessonErrorLoading": MessageLookupByLibrary.simpleMessage(
            "Sorry, there was an error loading this lesson. Please try again later."),
        "lessonNotFound": MessageLookupByLibrary.simpleMessage(
            "Sorry, this lesson is not available yet. Please check back later."),
        "lessons": MessageLookupByLibrary.simpleMessage("Lessons"),
        "letsPlay": MessageLookupByLibrary.simpleMessage("Let\'s Play! 🚀"),
        "letsStartPlaying":
            MessageLookupByLibrary.simpleMessage("Let\'s start playing!"),
        "logOut": MessageLookupByLibrary.simpleMessage("Log Out"),
        "login": MessageLookupByLibrary.simpleMessage("Login"),
        "myProfile": MessageLookupByLibrary.simpleMessage("My Profile"),
        "myProgress": MessageLookupByLibrary.simpleMessage("My Progress"),
        "nameCannotBeEmpty":
            MessageLookupByLibrary.simpleMessage("Name cannot be empty"),
        "needMoreCoins":
            MessageLookupByLibrary.simpleMessage("Need More Coins! 🪙"),
        "newExplorer": MessageLookupByLibrary.simpleMessage("New Explorer"),
        "newPasswordHint":
            MessageLookupByLibrary.simpleMessage("Choose a new password"),
        "newPasswordLabel":
            MessageLookupByLibrary.simpleMessage("New Password"),
        "next": MessageLookupByLibrary.simpleMessage("Next"),
        "notEnoughCoinsMessage": m3,
        "okay": MessageLookupByLibrary.simpleMessage("Okay"),
        "onboardingGamesDesc": MessageLookupByLibrary.simpleMessage(
            "Complete your path by playing games like bubble popping, word matching, letter connecting, and sound puzzles!"),
        "onboardingGamesTitle":
            MessageLookupByLibrary.simpleMessage("Play Fun Games 🎮"),
        "onboardingHiChampDesc": MessageLookupByLibrary.simpleMessage(
            "Welcome to EduFocus! We\'re super excited to have you here. Let\'s start a fun learning adventure together!"),
        "onboardingHiChampTitle":
            MessageLookupByLibrary.simpleMessage("Hi Champ! 🚀"),
        "onboardingStarsDesc": MessageLookupByLibrary.simpleMessage(
            "Earn stars to purchase cool outfits for your custom Lego character. You can also enable eye-tracking in your profile!"),
        "onboardingStarsTitle":
            MessageLookupByLibrary.simpleMessage("Stars & Customization 🪙"),
        "onboardingSubjectDesc": MessageLookupByLibrary.simpleMessage(
            "Select from English, Math, Arabic, and more. Tap on any subject to see all its units and lessons!"),
        "onboardingSubjectTitle":
            MessageLookupByLibrary.simpleMessage("Choose a Subject 📚"),
        "overallProgress":
            MessageLookupByLibrary.simpleMessage("Overall Progress"),
        "pantsTab": MessageLookupByLibrary.simpleMessage("Pants"),
        "parentEmailLabel":
            MessageLookupByLibrary.simpleMessage("Parent\'s Email"),
        "parentPortal": MessageLookupByLibrary.simpleMessage("Parent Portal"),
        "parentPortalDescription": MessageLookupByLibrary.simpleMessage(
            "Sign in to set up a safe learning environment for your hero."),
        "parentPortalFooter": MessageLookupByLibrary.simpleMessage(
            "Once signed in, the child\'s world begins.This screen will not appear again."),
        "password": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("Password"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("Password is required"),
        "passwordTooShort": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 6 characters"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "profileSetupTitle":
            MessageLookupByLibrary.simpleMessage("Let\'s set up your profile!"),
        "profileUpdatedError": m4,
        "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
            "Profile updated successfully! ✨"),
        "redo": MessageLookupByLibrary.simpleMessage("Redo"),
        "resetCodeHint":
            MessageLookupByLibrary.simpleMessage("Enter 6-digit code"),
        "resetCodeLabel":
            MessageLookupByLibrary.simpleMessage("Reset Code / OTP"),
        "resetCodeRequired":
            MessageLookupByLibrary.simpleMessage("Reset code is required"),
        "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
            "Enter the reset code sent to your email and choose a new password."),
        "resetPasswordTitle":
            MessageLookupByLibrary.simpleMessage("Reset Password"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
        "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
        "shirtTab": MessageLookupByLibrary.simpleMessage("Shirt"),
        "shopLoadError": m5,
        "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "startLearning": MessageLookupByLibrary.simpleMessage("Start Learning"),
        "streak": MessageLookupByLibrary.simpleMessage("Streak"),
        "textIconSize":
            MessageLookupByLibrary.simpleMessage("Text & Icon Size"),
        "textIconSizeDescription": MessageLookupByLibrary.simpleMessage(
            "Adjust for better visibility"),
        "totalPoints": MessageLookupByLibrary.simpleMessage("Total Points"),
        "trophyFirstWin": MessageLookupByLibrary.simpleMessage("First Win"),
        "trophyMaster": MessageLookupByLibrary.simpleMessage("Master"),
        "trophyNumbers": MessageLookupByLibrary.simpleMessage("Numbers"),
        "trophyRoom": MessageLookupByLibrary.simpleMessage("Trophy Room"),
        "trophySpeedy": MessageLookupByLibrary.simpleMessage("Speedy"),
        "trophyStreak3": MessageLookupByLibrary.simpleMessage("Streak x3"),
        "trophyWords": MessageLookupByLibrary.simpleMessage("Words"),
        "typeYourNameHint":
            MessageLookupByLibrary.simpleMessage("Type your name here..."),
        "undo": MessageLookupByLibrary.simpleMessage("Undo"),
        "units": MessageLookupByLibrary.simpleMessage("Units"),
        "unlockButton": m6,
        "unlockFailed": m7,
        "unlockPiece": MessageLookupByLibrary.simpleMessage("Unlock Piece! 🌟"),
        "unlockSuccess": MessageLookupByLibrary.simpleMessage(
            "Successfully unlocked item! 🎉"),
        "welcomeHero": m8,
        "badgeFirstWord": MessageLookupByLibrary.simpleMessage("First Word"),
        "badgePerfectScore": MessageLookupByLibrary.simpleMessage("Perfect Score"),
        "badgeStreak3": MessageLookupByLibrary.simpleMessage("3 Day Streak"),
        "badgePuzzleMaster": MessageLookupByLibrary.simpleMessage("Puzzle Master"),
        "profileUserAge": m9,
        "profileHeroTitle": MessageLookupByLibrary.simpleMessage("Letter Hero"),
        "streakDaysValue": m10,
        "sentencesUnit": MessageLookupByLibrary.simpleMessage("Sentences"),
        "wordsUnit2": MessageLookupByLibrary.simpleMessage("Words II"),
        "wordsUnit1": MessageLookupByLibrary.simpleMessage("Words I"),
        "lettersUnit2": MessageLookupByLibrary.simpleMessage("Letters II"),
        "lettersUnit1": MessageLookupByLibrary.simpleMessage("Letters I"),
        "supermarketTitle": MessageLookupByLibrary.simpleMessage("Supermarket"),
        "supermarketDesc": MessageLookupByLibrary.simpleMessage(
            "Continue your shopping adventure!"),
        "playAgain": MessageLookupByLibrary.simpleMessage("Play Again"),
        "splashSubTitle": MessageLookupByLibrary.simpleMessage(
            "Learning that feels like playing."),
        "homeTab": MessageLookupByLibrary.simpleMessage("Home"),
        "progressTab": MessageLookupByLibrary.simpleMessage("Progress"),
        "profileTab": MessageLookupByLibrary.simpleMessage("Profile"),
        "resetCodeNotificationTitle": MessageLookupByLibrary.simpleMessage("EduFocus Reset Code"),
        "resetCodeNotificationBody": m11,
        "lessonsCount": m12,
        "completePrevUnitFirst": MessageLookupByLibrary.simpleMessage(
            "Complete the previous unit first"),
        "lessonsFraction": m13,
        "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
        "finishedUnit": m14,
        "allUnitsConquered": m15,
        "unitCompleted": m16,
        "amazingProgress": m17,
        "nextUnit": MessageLookupByLibrary.simpleMessage("Next Unit"),
        "lessonFractionPrefix": m18,
        "lessonComplete": MessageLookupByLibrary.simpleMessage("Lesson Complete!"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again!"),
        "lessonScore": m19,
        "needTwoStars": MessageLookupByLibrary.simpleMessage("You need at least 2 stars to pass."),
        "nextLesson": MessageLookupByLibrary.simpleMessage("➡️  Next Lesson"),
        "tryAgainBtn": MessageLookupByLibrary.simpleMessage("🔄  Try Again"),
        "backToLessons": MessageLookupByLibrary.simpleMessage("Back to Lessons →"),
        "ttsPraise": MessageLookupByLibrary.simpleMessage("Excellent! Well done!"),
        "ttsTryAgain": MessageLookupByLibrary.simpleMessage("Try again! You can do it!"),
        "ttsFailed": MessageLookupByLibrary.simpleMessage("Try again to get at least 2 stars and pass!"),
        "ttsCompleted": m20
      };
}
