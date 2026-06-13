import 'package:edufocus/features/subjects/models/avatar_shop_model.dart';

class ChildModel {
  final String id;
  final String parentId;
  final String name;
  final int age;
  final String mode;
  final int coins;
  final int stars;
  final int currentStreak;
  final EquippedAvatar? equippedAvatar;

  ChildModel({
    required this.id,
    required this.parentId,
    required this.name,
    required this.age,
    required this.mode,
    required this.coins,
    required this.stars,
    required this.currentStreak,
    this.equippedAvatar,
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
      stars: json['stars'] is int
          ? json['stars'] as int
          : int.tryParse(json['stars']?.toString() ?? '') ?? 0,
      currentStreak: (json['current_streak'] ?? json['currentStreak']) is int
          ? (json['current_streak'] ?? json['currentStreak']) as int
          : int.tryParse(
                  (json['current_streak'] ?? json['currentStreak'])
                          ?.toString() ??
                      '',
                ) ??
                0,
      equippedAvatar: json['equipped_avatar'] != null
          ? EquippedAvatar.fromJson(json['equipped_avatar'] as Map<String, dynamic>)
          : json['equippedAvatar'] != null
              ? EquippedAvatar.fromJson(json['equippedAvatar'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'parent_id': parentId,
    'name': name,
    'age': age,
    'mode': mode,
    'coins': coins,
    'stars': stars,
    'current_streak': currentStreak,
    if (equippedAvatar != null) 'equipped_avatar': equippedAvatar!.toJson(),
  };

  ChildModel copyWith({
    String? id,
    String? parentId,
    String? name,
    int? age,
    String? mode,
    int? coins,
    int? stars,
    int? currentStreak,
    EquippedAvatar? equippedAvatar,
  }) {
    return ChildModel(
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      age: age ?? this.age,
      mode: mode ?? this.mode,
      coins: coins ?? this.coins,
      stars: stars ?? this.stars,
      currentStreak: currentStreak ?? this.currentStreak,
      equippedAvatar: equippedAvatar ?? this.equippedAvatar,
    );
  }
}

