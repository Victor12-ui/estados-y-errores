class PostModel {
  final int id;
  final String title;
  final String body;

  PostModel({required this.id, required this.title, required this.body});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] is int ? json['id'] : 0,
      title: json['title']?.toString() ?? 'Sin título',
      body: json['body']?.toString() ?? 'Sin contenido',
    );
  }
}
