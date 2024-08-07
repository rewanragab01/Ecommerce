class Category {
  final String name;
  final String image;
  final int id;

  Category({required this.name, required this.image, required this.id});

  // Convert JSON to Category instance
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      image: json['image'],
      id: json['id'],
    );
  }
}
