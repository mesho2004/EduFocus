class OptionModel {
  final String? text;
  final bool? isCorrect;
  final String? category; // Sorter template
  final int? order;       // Sequencer template
  final String? imageHint;
  final String? imagePath;
  final String? audioPath;

  OptionModel({
    this.text,
    this.isCorrect,
    this.category,
    this.order,
    this.imageHint,
    this.imagePath,
    this.audioPath,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['text'] as String?,
      isCorrect: json['isCorrect'] as bool?,
      category: json['category'] as String?,
      order: (json['order'] ?? json['sequenceOrder']) as int?,
      imageHint: (json['imageHint'] ?? json['imagePath']) as String?,
      imagePath: (json['imagePath'] ?? json['imageHint']) as String?,
      audioPath: json['audioPath'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        if (text != null) 'text': text,
        if (isCorrect != null) 'isCorrect': isCorrect,
        if (category != null) 'category': category,
        if (order != null) 'order': order,
        if (imageHint != null) 'imageHint': imageHint,
        if (imagePath != null) 'imagePath': imagePath,
        if (audioPath != null) 'audioPath': audioPath,
      };
}