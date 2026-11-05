class Notice {
  const Notice({
    required this.id,
    required this.title,
    required this.department,
    required this.description,
    required this.date,
  });

  final String id;
  final String title;
  final String department;
  final String description;
  final DateTime date;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'department': department,
        'description': description,
        'date': date.toIso8601String(),
      };

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      id: json['id'] as String,
      title: json['title'] as String,
      department: json['department'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
    );
  }
}
