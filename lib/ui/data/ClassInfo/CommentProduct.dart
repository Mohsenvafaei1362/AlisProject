class CommentProduct {
  final String comment;
  final String name;
  final String date;

  CommentProduct(this.comment, this.name, this.date);
  CommentProduct.fromJson(Map json)
      : comment = json['comment'],
        name = json['name'],
        date = json['date'];
}
