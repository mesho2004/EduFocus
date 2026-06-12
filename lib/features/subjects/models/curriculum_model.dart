import 'unit_model.dart';

class CurriculumModel {
  final String id;
  final String subjectType;
  final int term;
  final int grade;
  final int totalUnits;
  final List<UnitModel> units;

  CurriculumModel({
    required this.id,
    required this.subjectType,
    required this.term,
    required this.grade,
    required this.totalUnits,
    required this.units,
  });

  factory CurriculumModel.fromJson(Map<String, dynamic> json) {
    return CurriculumModel(
      id: json['id'] as String,
      subjectType: json['subjectType'] as String,
      term: json['term'] as int,
      grade: json['grade'] as int,
      totalUnits: json['totalUnits'] as int,
      units: (json['units'] as List<dynamic>)
          .map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'subjectType': subjectType,
    'term': term,
    'grade': grade,
    'totalUnits': totalUnits,
    'units': units.map((u) => u.toJson()).toList(),
  };
}
