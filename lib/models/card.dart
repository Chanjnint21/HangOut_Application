class CardItem {
  const CardItem({
    required this.id,
    required this.author,
    required this.category,
    required this.departure,
    required this.destination,
    required this.image,
    required this.postDate,
    required this.postTime,
    required this.requirement,
    required this.start_date,
    required this.title,
    required this.expiry,
    required this.detail,
    required this.end_date,
  });

  final String id;
  final Map<String, dynamic> author;
  final dynamic category;
  final Map<String, dynamic> departure;
  final String destination;
  final dynamic image;
  final String postDate;
  final String postTime;
  final Map<String, dynamic> requirement;
  final String start_date;
  final String title;
  final bool expiry;
  final String detail;
  final String end_date;
}
