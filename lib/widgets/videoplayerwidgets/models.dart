class Lecture {
  final String title;
  final String chapter;
  final String duration;
  final DateTime date;

  Lecture({
    required this.title,
    required this.chapter,
    required this.duration,
    required this.date,
  });
}

List<Lecture> lectures = List.generate(
  10,
  (index) => Lecture(
    title: "Lecture Title $index",
    chapter: "Chapter $index",
    duration: "2hr 10min",
    date: DateTime(2025, 3, 25),
  ),
);
