import 'dart:convert';

// ─────────────────────────────────────────────
//  Enums
// ─────────────────────────────────────────────

enum SubjectType { arabic, english, math }

enum GameTemplate { selector, sorter, sequence, sequencer, matcher, popper, connectLetters }

enum GameTheme { beach, jungle, space }

// ─────────────────────────────────────────────
//  Game Option Data
// ─────────────────────────────────────────────

class GameOptionData {
  final String? text;
  final String? imagePath;
  final String? audioPath;
  final bool isCorrect;
  final String? category;

  /// Used by SequenceGame — the 1-based position this item should appear in.
  final int? sequenceOrder;

  const GameOptionData({
    this.text,
    this.imagePath,
    this.audioPath,
    required this.isCorrect,
    this.sequenceOrder,
    this.category,
  });

  factory GameOptionData.fromJson(Map<String, dynamic> json) {
    return GameOptionData(
      text: json['text'] as String?,
      imagePath: (json['imagePath'] ?? json['imageHint']) as String?,
      audioPath: json['audioPath'] as String?,
      isCorrect: (json['isCorrect'] as bool?) ?? false,
      sequenceOrder: (json['sequenceOrder'] ?? json['order']) as int?,
      category: json['category'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'text': text,
        'imagePath': imagePath,
        'audioPath': audioPath,
        'isCorrect': isCorrect,
        'sequenceOrder': sequenceOrder,
        'category': category,
      };
}

// ─────────────────────────────────────────────
//  Match Pair (used by MatcherGame)
// ─────────────────────────────────────────────

class MatchPair {
  final String left;
  final String right;

  const MatchPair({required this.left, required this.right});

  factory MatchPair.fromJson(Map<String, dynamic> json) {
    return MatchPair(
      left: json['left'] as String? ?? '',
      right: json['right'] as String? ?? '',
    );
  }
}

// ─────────────────────────────────────────────
//  Single Question
// ─────────────────────────────────────────────

class GameQuestion {
  /// The question prompt — either plain text or a path to an image asset.
  final String question;
  final bool questionIsImage;
  final List<GameOptionData> options;
  final List<MatchPair> pairs;

  const GameQuestion({
    required this.question,
    required this.questionIsImage,
    required this.options,
    this.pairs = const [],
  });

  factory GameQuestion.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'] as List<dynamic>? ?? [];
    final rawPairs = json['pairs'] as List<dynamic>? ?? [];
    return GameQuestion(
      question: json['question'] as String? ?? '',
      questionIsImage: (json['questionIsImage'] as bool?) ?? false,
      options: rawOptions
          .map((o) => GameOptionData.fromJson(o as Map<String, dynamic>))
          .toList(),
      pairs: rawPairs
          .map((p) => MatchPair.fromJson(p as Map<String, dynamic>))
          .toList(),
    );
  }
}

// ─────────────────────────────────────────────
//  Lesson Content  (root model, injected into engine)
// ─────────────────────────────────────────────

class LessonContent {
  final String lessonTitle;
  final SubjectType subjectType;
  final GameTemplate gameTemplate;
  final GameTheme theme;
  final List<GameQuestion> questions;
  final int? unitId;
  final int? lessonIndex;
  final int? grade;
  final int? term;
  final String? rawSubjectType;

  const LessonContent({
    required this.lessonTitle,
    required this.subjectType,
    required this.gameTemplate,
    required this.theme,
    required this.questions,
    this.unitId,
    this.lessonIndex,
    this.grade,
    this.term,
    this.rawSubjectType,
  });

  // ── JSON parsing ────────────────────────────

  factory LessonContent.fromJson(Map<String, dynamic> json) {
    return LessonContent(
      lessonTitle: json['lessonTitle'] as String? ?? '',
      subjectType: _parseSubject(json['subjectType'] as String? ?? ''),
      gameTemplate: _parseTemplate(json['gameTemplate'] as String? ?? ''),
      theme: _parseTheme(json['theme'] as String? ?? ''),
      questions: (json['questions'] as List<dynamic>? ?? [])
          .map((q) => GameQuestion.fromJson(q as Map<String, dynamic>))
          .toList(),
      unitId: json['unitId'] as int?,
      lessonIndex: json['lessonIndex'] as int?,
      grade: json['grade'] as int?,
      term: json['term'] as int?,
      rawSubjectType: json['rawSubjectType'] as String?,
    );
  }

  /// Convenience constructor that accepts a raw JSON string.
  factory LessonContent.fromJsonString(String raw) {
    return LessonContent.fromJson(
        jsonDecode(raw) as Map<String, dynamic>);
  }

  // ── Helpers ─────────────────────────────────

  /// Returns true when the layout should be right-to-left.
  bool get isRtl =>
      subjectType == SubjectType.arabic || subjectType == SubjectType.math;

  /// Returns the TTS language code for this lesson.
  String get ttsLanguage {
    switch (subjectType) {
      case SubjectType.arabic:
        return 'ar-EG';
      case SubjectType.english:
        return 'en-US';
      case SubjectType.math:
        return 'ar-EG'; // Maths in Egyptian curriculum is taught in Arabic
    }
  }

  // ── Private helpers ──────────────────────────

  static SubjectType _parseSubject(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('arabic')) {
      return SubjectType.arabic;
    } else if (lower.contains('math')) {
      return SubjectType.math;
    }
    return SubjectType.english;
  }

  static GameTemplate _parseTemplate(String raw) {
    switch (raw.toLowerCase()) {
      case 'sorter':
        return GameTemplate.sorter;
      case 'sequence':
        return GameTemplate.sequence;
      case 'sequencer':
        return GameTemplate.sequencer;
      case 'matcher':
        return GameTemplate.matcher;
      case 'popper':
        return GameTemplate.popper;
      case 'connectletters':
      case 'connect_letters':
        return GameTemplate.connectLetters;
      default:
        return GameTemplate.selector;
    }
  }

  static GameTheme _parseTheme(String raw) {
    switch (raw.toLowerCase()) {
      case 'jungle':
        return GameTheme.jungle;
      case 'space':
        return GameTheme.space;
      default:
        return GameTheme.beach;
    }
  }
}
