class ListTicketInfo {
  final String title;
  final String nameSupport;
  final DateTime date;
  final String description;

  ListTicketInfo(
    this.title,
    this.nameSupport,
    this.date,
    this.description,
  );

  ListTicketInfo.fromJson(Map json)
      : title = json['title'],
        nameSupport = json['nameSupport'],
        date = json['date'],
        description = json['description'];
}
