class TipModel {
  final int id;
  final String title;
  final String description;

  TipModel({required this.id, required this.title, required this.description});

  factory TipModel.fromJson(Map<String, dynamic> json) {
    return TipModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}