class CourseModel {
  final String name;
  final String imageUrl;

  CourseModel({required this.name, required this.imageUrl});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
