class ArticalsModel {
  final String? image;
  final String? title;
  final String? subtitle;
  final String content;
  final String url;
  final String publishedAt;
  final String author;

  ArticalsModel({
    required this.image,
    required this.title,
    required this.subtitle,
    this.content = '',
    this.url = '',
    this.publishedAt = '',
    this.author = '',
  });
}

class Source {
  final String? id;
  final String? name;

  Source({required this.id, required this.name});
}
