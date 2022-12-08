class NewTicketInfo {
  final String title;
  final String description;
  final int orderNumber;

  NewTicketInfo(
    this.title,
    this.description,
    this.orderNumber,
  );

  NewTicketInfo.fromJson(Map json)
      : title = json['title'],
        description = json['description'],
        orderNumber = json['orderNumber'];
}
