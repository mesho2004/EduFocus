import 'lesson_model.dart';

class UnitModel {
  final int id;
  final String title;
  final String theme;
  final List<LessonModel> lessons;

  UnitModel({
    required this.id,
    required this.title,
    required this.theme,
    required this.lessons,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as int,
      title: json['title'] as String,
      theme: json['theme'] as String,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => LessonModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'theme': theme,
        'lessons': lessons.map((l) => l.toJson()).toList(),
      };
}