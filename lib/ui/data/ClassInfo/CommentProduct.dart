class CommentProduct {
  final String title;
  final String desc;
  final String name;
  final DateTime date;

  CommentProduct(
    this.title,
    this.desc,
    this.name,
    this.date,
  );
  CommentProduct.fromJson(Map json)
      : title = json['title'],
        desc = json['desc'],
        name = json['name'],
        date = json['date'];
}
