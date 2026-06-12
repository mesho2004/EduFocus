class ChildModel {
  final String id;
  final String parentId;
  final String name;
  final int age;
  final String mode;
  final int coins;
  final int currentStreak;

  ChildModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.age,
    required this.mode,
    required this.coins,
    required this.currentStreak,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: (json['id'] ?? '').toString(),
      parentId: (json['parent_id'] ?? json['parentId'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      age: json['age'] is int
          ? json['age'] as int
          : int.tryParse(json['age']?.toString() ?? '') ?? 0,
      mode: (json['mode'] ?? 'touch').toString(),
      coins: json['coins'] is int
          ? json['coins'] as int
          : int.tryParse(json['coins']?.toString() ?? '') ?? 0,
      currentStreak: (json['current_streak'] ?? json['currentStreak']) is int
          ? (json['current_streak'] ?? json['currentStreak']) as int
          : int.tryParse(
                  (json['current_streak'] ?? json['currentStreak'])
                          ?.toString() ??
                      '',
                ) ??
                0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'parent_id': parentId,
    'name': name,
    'age': age,
    'mode': mode,
    'coins': coins,
    'current_streak': currentStreak,
  };
}
