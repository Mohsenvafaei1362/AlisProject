class Comment {
  final int id;
  final String title, description;

  const Comment({
    required this.id,
    required this.title,
    required this.description,
  });
  static const List<Comment> comments_ab = [
    Comment(id: 1, title: 'آب معدنی', description: 'خوب بود توصیه میکنم'),
    Comment(id: 1, title: 'آب معدنی', description: 'با تخفیف می ارزه')
  ];
  static const List<Comment> comments_dogh = [
    Comment(
        id: 7,
        title: 'دوغ',
        description: 'در بین دوغ های موجود طعمش خیلی خوبه'),
    Comment(id: 7, title: 'دوغ', description: 'گران شده ولی خیلی خوبه')
  ];
  static const List<Comment> comments_abghaz = [
    Comment(id: 7, title: 'آبمیوه گازدار', description: 'خوب بود'),
  ];
  static const List<Comment> comments_abghazt = [
    Comment(id: 7, title: 'آبمیوه گازدار تشریفاتی', description: 'عالی'),
  ];
  static const List<Comment> comments_milkt = [
    Comment(id: 7, title: 'شیر طعم دار', description: 'خوش طعم و شیرین'),
  ];
  static const List<Comment> comments_noshabe = [
    Comment(id: 7, title: 'نوشابه', description: 'معمولی و قابل قبول'),
    Comment(id: 7, title: 'نوشابه', description: 'خوب بود')
  ];
  static const List<Comment> comments_milk = [
    Comment(
        id: 7,
        title: 'شیر ساده',
        description: 'ماندگاری بیشتری نسبت به بقیه شیر های بطری داره'),
  ];
  static const List<Comment> comments_delester = [
    Comment(id: 7, title: 'دلستر', description: 'کیفیتش خوب بود'),
    Comment(id: 7, title: 'دلستر', description: 'قیمتش عالیه')
  ];
  static const List<Comment> comments_abmive = [
    Comment(id: 7, title: 'آبمیوه', description: 'عالی ولی گرون'),
    Comment(id: 7, title: 'آبمیوه', description: 'معمولی و گران')
  ];
}

class PropertyProduct {
  final String taste;
  final num volume;
  final String property;

  const PropertyProduct({
    required this.taste,
    required this.volume,
    required this.property,
  });

  static const List<PropertyProduct> property_ab = [
    PropertyProduct(taste: '', volume: 1.5, property: ''),
  ];
}
