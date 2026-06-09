import 'option_model.dart';

class MatchPairModel {
  final String left;
  final String right;

  MatchPairModel({required this.left, required this.right});

  factory MatchPairModel.fromJson(Map<String, dynamic> json) {
    return MatchPairModel(
      left: json['left'] as String? ?? '',
      right: json['right'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'left': left,
        'right': right,
      };
}

class LessonModel {
  final String type;
  final String topic;
  final String gameTemplate;
  final String question;
  final bool questionIsImage;
  final List<OptionModel> options;
  final List<MatchPairModel>? pairs;

  LessonModel({
    required this.type,
    required this.topic,
    required this.gameTemplate,
    required this.question,
    this.questionIsImage = false,
    this.options = const [],
    this.pairs,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      type: json['type'] as String? ?? '',
      topic: json['topic'] as String? ?? '',
      gameTemplate: json['gameTemplate'] as String? ?? '',
      question: json['question'] as String? ?? '',
      questionIsImage: json['questionIsImage'] as bool? ?? false,
      options: (json['options'] as List<dynamic>?)
              ?.map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pairs: (json['pairs'] as List<dynamic>?)
          ?.map((e) => MatchPairModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'topic': topic,
        'gameTemplate': gameTemplate,
        'question': question,
        'questionIsImage': questionIsImage,
        'options': options.map((o) => o.toJson()).toList(),
        if (pairs != null) 'pairs': pairs!.map((p) => p.toJson()).toList(),
      };
}