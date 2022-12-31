class CommentProduct {
  final String comment;
  final String name;
  final String date;
  final int countlike;
  final int id;

  CommentProduct(
    this.comment,
    this.name,
    this.date,
    this.countlike,
    this.id,
  );
  CommentProduct.fromJson(Map json)
      : comment = json['comment'],
        name = json['name'],
        countlike = json['countlike'],
        id = json['id'],
        date = json['date'];
}
