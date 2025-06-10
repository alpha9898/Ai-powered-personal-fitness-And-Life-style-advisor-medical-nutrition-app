class Articalentity {
  final String id;
  final String title;
  final String description;
  String? url;
  String? image;

  Articalentity({
    required this.id,
    required this.title,
    required this.description,
    this.url,
    this.image,
  });
}
