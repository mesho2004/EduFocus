// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
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
  String get localeName => 'ar';

  static String m0(price) =>
      "هل تريد شراء هذا العنصر مقابل ${price} من العملات؟";

  static String m1(completed, total) =>
      "تم إكمال ${completed} من ${total} من الدروس";

  static String m2(name) => "مرحباً ${name}! 👋";

  static String m3(price, userCoins) =>
      "تحتاج إلى ${price} من العملات لشراء هذا، ولكن لديك ${userCoins} فقط. العب المزيد من الدروس لكسب العملات!";

  static String m4(error) => "خطأ أثناء تحديث الملف الشخصي: ${error} 😢";

  static String m5(error) => "خطأ في تحميل عناصر المتجر: ${error}";

  static String m6(price) => "فتح (${price} 🪙)";

  static String m7(error) => "فشل شراء العنصر: ${error}";

  static String m8(name) => "مرحباً، ${name}! لنبدأ التعلم! 🚀";

  static String m9(age) => "العمر: ${age}";

  static String m10(days) => "${days} يوم";

  static String m11(code) => "رمز إعادة التعيين الخاص بك هو: ${code}";

  static String m12(completed, total, pct) =>
      "${completed} / ${total} درس (${pct}%)";

  static String m13(completed, total) => "${completed} / ${total} درس";

  static String m14(unitTitle) => "عمل رائع! لقد أنهيت ${unitTitle}!";

  static String m15(score) => "تم اجتياز جميع الوحدات! النتيجة: ${score}";

  static String m16(unitTitle) => "تم إكمال ${unitTitle}!";

  static String m17(score) => "تقدم مذهل!\nالنقاط الكلية: ${score}";

  static String m18(current, total) => "الدرس ${current} / ${total}";

  static String m19(score, total) => "النتيجة: ${score} / ${total}";

  static String m20(stars) => "رائع! أنهيت الدرس وحصلت على ${stars} نجوم!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "AccountSettings":
            MessageLookupByLibrary.simpleMessage("إعدادات الحساب"),
        "AchievementsRewards":
            MessageLookupByLibrary.simpleMessage("الإنجازات والجوائز"),
        "Badges": MessageLookupByLibrary.simpleMessage("الشارات"),
        "English": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
        "adaptiveSettings":
            MessageLookupByLibrary.simpleMessage("إعدادات التكيف"),
        "ageCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "العمر لا يمكن أن يكون فارغاً"),
        "buyConfirmMessage": m0,
        "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
        "changeLanguage": MessageLookupByLibrary.simpleMessage("تغيير اللغة"),
        "childAgeLabel": MessageLookupByLibrary.simpleMessage("عمر الطفل"),
        "childNameLabel": MessageLookupByLibrary.simpleMessage("اسم الطفل"),
        "chooseFace": MessageLookupByLibrary.simpleMessage("اختر الوجه"),
        "chooseHair": MessageLookupByLibrary.simpleMessage("اختر الشعر"),
        "chooseHat": MessageLookupByLibrary.simpleMessage("اختر القبعة"),
        "choosePants": MessageLookupByLibrary.simpleMessage("اختر البنطال"),
        "chooseShirt": MessageLookupByLibrary.simpleMessage("اختر القميص"),
        "coins": MessageLookupByLibrary.simpleMessage("العملات"),
        "completed": MessageLookupByLibrary.simpleMessage("مكتمل"),
        "completedLessonsProgress": m1,
        "confirmNewPasswordHint": MessageLookupByLibrary.simpleMessage(
            "أعد إدخال كلمة المرور الجديدة"),
        "confirmNewPasswordLabel":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور الجديدة"),
        "confirmPassword":
            MessageLookupByLibrary.simpleMessage("تأكيد كلمة المرور"),
        "confirmPasswordHint":
            MessageLookupByLibrary.simpleMessage("أعد إدخال كلمة المرور"),
        "confirmPasswordRequired":
            MessageLookupByLibrary.simpleMessage("يرجى تأكيد كلمة المرور"),
        "createAccount": MessageLookupByLibrary.simpleMessage("إنشاء الحساب"),
        "darkMode": MessageLookupByLibrary.simpleMessage("الوضع الداكن"),
        "editProfile":
            MessageLookupByLibrary.simpleMessage("تعديل الملف الشخصي"),
        "email": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "emailHint": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
        "emailInvalid": MessageLookupByLibrary.simpleMessage(
            "أدخل بريداً إلكترونياً صحيحاً"),
        "emailRequired":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني مطلوب"),
        "enterAgeHint": MessageLookupByLibrary.simpleMessage("أدخل العمر"),
        "enterNameError":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال اسمك"),
        "enterNameHint": MessageLookupByLibrary.simpleMessage("أدخل الاسم"),
        "enterValidAge":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال عمر صحيح"),
        "eyeMode": MessageLookupByLibrary.simpleMessage("وضع تتبع العين"),
        "eyeModeDescription":
            MessageLookupByLibrary.simpleMessage("تمكين وضع تتبع العين"),
        "faceTab": MessageLookupByLibrary.simpleMessage("الوجه"),
        "forgotPassword":
            MessageLookupByLibrary.simpleMessage("نسيت كلمة المرور؟"),
        "forgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
            "أدخل بريدك الإلكتروني المسجل لتلقي رمز إعادة تعيين كلمة المرور."),
        "gamesWon":
            MessageLookupByLibrary.simpleMessage("الألعاب التي تم الفوز بها"),
        "hairTab": MessageLookupByLibrary.simpleMessage("الشعر"),
        "hatTab": MessageLookupByLibrary.simpleMessage("القبعة"),
        "heroAge": MessageLookupByLibrary.simpleMessage("كم عمر بطلك؟"),
        "heroFooter": MessageLookupByLibrary.simpleMessage(
            "الأبوان: يمكنك تغيير هذه الإعدادات لاحقًا في القائمة"),
        "heroName": MessageLookupByLibrary.simpleMessage("ما هو اسم بطلك؟"),
        "heroNameError":
            MessageLookupByLibrary.simpleMessage("يرجى إدخال اسم بطلك"),
        "heroNameHint": MessageLookupByLibrary.simpleMessage("أدخل اسم بطلك"),
        "hiChamp": MessageLookupByLibrary.simpleMessage("مرحبًا، البطل!"),
        "hiName": m2,
        "homeDescription": MessageLookupByLibrary.simpleMessage(
            "اختر مادة دراسية وابدأ باللعب!"),
        "howOldAreYou": MessageLookupByLibrary.simpleMessage("كم عمرك؟"),
        "lessonErrorLoading": MessageLookupByLibrary.simpleMessage(
            "عذرًا، حدث خطأ أثناء تحميل هذا الدرس. يرجى المحاولة مرة أخرى لاحقًا."),
        "lessonNotFound": MessageLookupByLibrary.simpleMessage(
            "عذرًا، هذا الدرس غير متوفر بعد. يرجى التحقق لاحقًا."),
        "lessons": MessageLookupByLibrary.simpleMessage("دروس"),
        "letsPlay": MessageLookupByLibrary.simpleMessage("هيا نلعب! 🚀"),
        "letsStartPlaying":
            MessageLookupByLibrary.simpleMessage("هيا نبدأ اللعب!"),
        "logOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
        "login": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
        "myProfile": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
        "myProgress": MessageLookupByLibrary.simpleMessage("التقدم الخاص بي"),
        "nameCannotBeEmpty": MessageLookupByLibrary.simpleMessage(
            "الاسم لا يمكن أن يكون فارغاً"),
        "needMoreCoins":
            MessageLookupByLibrary.simpleMessage("بحاجة للمزيد من العملات! 🪙"),
        "newExplorer": MessageLookupByLibrary.simpleMessage("مستكشف جديد"),
        "newPasswordHint":
            MessageLookupByLibrary.simpleMessage("اختر كلمة مرور جديدة"),
        "newPasswordLabel":
            MessageLookupByLibrary.simpleMessage("كلمة المرور الجديدة"),
        "next": MessageLookupByLibrary.simpleMessage("التالي"),
        "notEnoughCoinsMessage": m3,
        "okay": MessageLookupByLibrary.simpleMessage("موافق"),
        "onboardingGamesDesc": MessageLookupByLibrary.simpleMessage(
            "أكمل مسارك باللعب بألعاب مثل فرقعة الفقاعات، مطابقة الكلمات، توصيل الحروف، وألغاز الأصوات!"),
        "onboardingGamesTitle":
            MessageLookupByLibrary.simpleMessage("العب ألعاباً ممتعة 🎮"),
        "onboardingHiChampDesc": MessageLookupByLibrary.simpleMessage(
            "مرحباً بك في EduFocus! نحن متحمسون جداً لوجودك معنا. دعنا نبدأ مغامرة تعليمية ممتعة معاً!"),
        "onboardingHiChampTitle":
            MessageLookupByLibrary.simpleMessage("مرحباً يا بطل! 🚀"),
        "onboardingStarsDesc": MessageLookupByLibrary.simpleMessage(
            "اكسب النجوم لشراء ملابس رائعة لشخصية الليجو المخصصة لك. يمكنك أيضاً تمكين تتبع العين في ملفك الشخصي!"),
        "onboardingStarsTitle":
            MessageLookupByLibrary.simpleMessage("النجوم والتخصيص 🪙"),
        "onboardingSubjectDesc": MessageLookupByLibrary.simpleMessage(
            "اختر من بين اللغة الإنجليزية، الرياضيات، العربية، والمزيد. اضغط على أي مادة لمشاهدة جميع الوحدات والدروس!"),
        "onboardingSubjectTitle":
            MessageLookupByLibrary.simpleMessage("اختر مادة دراسية 📚"),
        "overallProgress": MessageLookupByLibrary.simpleMessage("التقدم الكلي"),
        "pantsTab": MessageLookupByLibrary.simpleMessage("البنطال"),
        "parentEmailLabel":
            MessageLookupByLibrary.simpleMessage("البريد الإلكتروني للوالدين"),
        "parentPortal": MessageLookupByLibrary.simpleMessage("بوابة الآباء"),
        "parentPortalDescription": MessageLookupByLibrary.simpleMessage(
            "سجل الدخول لإعداد بيئة تعليمية آمنة لبطل طفلك."),
        "parentPortalFooter": MessageLookupByLibrary.simpleMessage(
            "بمجرد تسجيل الدخول، يبدأ عالم الطفل. هذه الشاشة لن تظهر مرة أخرى."),
        "password": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordHint": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
        "passwordRequired":
            MessageLookupByLibrary.simpleMessage("كلمة المرور مطلوبة"),
        "passwordTooShort": MessageLookupByLibrary.simpleMessage(
            "يجب أن تكون كلمة المرور 6 أحرف على الأقل"),
        "passwordsDoNotMatch":
            MessageLookupByLibrary.simpleMessage("كلمات المرور غير متطابقة"),
        "profileSetupTitle":
            MessageLookupByLibrary.simpleMessage("دعنا نعد ملفك الشخصي!"),
        "profileUpdatedError": m4,
        "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
            "تم تحديث الملف الشخصي بنجاح! ✨"),
        "redo": MessageLookupByLibrary.simpleMessage("إعادة"),
        "resetCodeHint": MessageLookupByLibrary.simpleMessage(
            "أدخل الرمز المكون من 6 أرقام"),
        "resetCodeLabel": MessageLookupByLibrary.simpleMessage(
            "رمز إعادة التعيين / رمز التحقق"),
        "resetCodeRequired":
            MessageLookupByLibrary.simpleMessage("رمز إعادة التعيين مطلوب"),
        "resetPasswordDescription": MessageLookupByLibrary.simpleMessage(
            "أدخل رمز إعادة التعيين المرسل إلى بريدك الإلكتروني واختر كلمة مرور جديدة."),
        "resetPasswordTitle":
            MessageLookupByLibrary.simpleMessage("إعادة تعيين كلمة المرور"),
        "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
        "save": MessageLookupByLibrary.simpleMessage("حفظ"),
        "saveChanges": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
        "sendCode": MessageLookupByLibrary.simpleMessage("إرسال الرمز"),
        "shirtTab": MessageLookupByLibrary.simpleMessage("القميص"),
        "shopLoadError": m5,
        "signUp": MessageLookupByLibrary.simpleMessage("التسجيل"),
        "skip": MessageLookupByLibrary.simpleMessage("تخطي"),
        "startLearning": MessageLookupByLibrary.simpleMessage("ابدأ التعلم"),
        "streak": MessageLookupByLibrary.simpleMessage("الاستمرارية"),
        "textIconSize":
            MessageLookupByLibrary.simpleMessage("حجم النص والرموز"),
        "textIconSizeDescription":
            MessageLookupByLibrary.simpleMessage("ضبط لتحسين الرؤية"),
        "totalPoints": MessageLookupByLibrary.simpleMessage("النقاط الكلية"),
        "trophyFirstWin": MessageLookupByLibrary.simpleMessage("الفوز الأول"),
        "trophyMaster": MessageLookupByLibrary.simpleMessage("البطل"),
        "trophyNumbers": MessageLookupByLibrary.simpleMessage("الأرقام"),
        "trophyRoom": MessageLookupByLibrary.simpleMessage("غرفة الجوائز"),
        "trophySpeedy": MessageLookupByLibrary.simpleMessage("السريع"),
        "trophyStreak3":
            MessageLookupByLibrary.simpleMessage("استمرارية 3 أيام"),
        "trophyWords": MessageLookupByLibrary.simpleMessage("الكلمات"),
        "typeYourNameHint":
            MessageLookupByLibrary.simpleMessage("اكتب اسمك هنا..."),
        "undo": MessageLookupByLibrary.simpleMessage("تراجع"),
        "units": MessageLookupByLibrary.simpleMessage("وحدات"),
        "unlockButton": m6,
        "unlockFailed": m7,
        "unlockPiece": MessageLookupByLibrary.simpleMessage("فتح القطعة! 🌟"),
        "unlockSuccess":
            MessageLookupByLibrary.simpleMessage("تم فتح العنصر بنجاح! 🎉"),
        "welcomeHero": m8,
        "badgeFirstWord": MessageLookupByLibrary.simpleMessage("الكلمة الأولى"),
        "badgePerfectScore": MessageLookupByLibrary.simpleMessage("الدرجة الكاملة"),
        "badgeStreak3": MessageLookupByLibrary.simpleMessage("استمرارية ٣ أيام"),
        "badgePuzzleMaster": MessageLookupByLibrary.simpleMessage("سيد الألغاز"),
        "profileUserAge": m9,
        "profileHeroTitle": MessageLookupByLibrary.simpleMessage("بطل الحروف"),
        "streakDaysValue": m10,
        "sentencesUnit": MessageLookupByLibrary.simpleMessage("الجمل"),
        "wordsUnit2": MessageLookupByLibrary.simpleMessage("الكلمات ٢"),
        "wordsUnit1": MessageLookupByLibrary.simpleMessage("الكلمات ١"),
        "lettersUnit2": MessageLookupByLibrary.simpleMessage("الحروف ٢"),
        "lettersUnit1": MessageLookupByLibrary.simpleMessage("الحروف ١"),
        "supermarketTitle": MessageLookupByLibrary.simpleMessage("السوبرماركت"),
        "supermarketDesc": MessageLookupByLibrary.simpleMessage(
            "أكمل مغامرة التسوق الخاصة بك!"),
        "playAgain": MessageLookupByLibrary.simpleMessage("العب مجدداً"),
        "splashSubTitle": MessageLookupByLibrary.simpleMessage(
            "التعلم الذي يبدو وكأنه لعب."),
        "homeTab": MessageLookupByLibrary.simpleMessage("الرئيسية"),
        "progressTab": MessageLookupByLibrary.simpleMessage("التقدم"),
        "profileTab": MessageLookupByLibrary.simpleMessage("الملف الشخصي"),
        "resetCodeNotificationTitle": MessageLookupByLibrary.simpleMessage("رمز إعادة تعيين EduFocus"),
        "resetCodeNotificationBody": m11,
        "lessonsCount": m12,
        "completePrevUnitFirst": MessageLookupByLibrary.simpleMessage(
            "أكمل الوحدة السابقة أولاً"),
        "lessonsFraction": m13,
        "selectLanguage": MessageLookupByLibrary.simpleMessage("اختر اللغة"),
        "finishedUnit": m14,
        "allUnitsConquered": m15,
        "unitCompleted": m16,
        "amazingProgress": m17,
        "nextUnit": MessageLookupByLibrary.simpleMessage("الوحدة التالية"),
        "lessonFractionPrefix": m18,
        "lessonComplete": MessageLookupByLibrary.simpleMessage("اكتمل الدرس!"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("حاول مجدداً!"),
        "lessonScore": m19,
        "needTwoStars": MessageLookupByLibrary.simpleMessage("تحتاج إلى نجمتين على الأقل لاجتياز الدرس."),
        "nextLesson": MessageLookupByLibrary.simpleMessage("➡️  الدرس التالي"),
        "tryAgainBtn": MessageLookupByLibrary.simpleMessage("🔄  حاول مجدداً"),
        "backToLessons": MessageLookupByLibrary.simpleMessage("العودة إلى الدروس ←"),
        "ttsPraise": MessageLookupByLibrary.simpleMessage("أحسنت! إجابة صحيحة!"),
        "ttsTryAgain": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى!"),
        "ttsFailed": MessageLookupByLibrary.simpleMessage("حاول مرة أخرى لتحصل على نجمتين أو أكثر وتجتاز الدرس!"),
        "ttsCompleted": m20
      };
}
