part of 'detailes_bloc.dart';

abstract class DetailesEvent extends Equatable {
  const DetailesEvent();
  @override
  List<Object?> get props => [];
}

class DetailesStarted extends DetailesEvent {
  final int productId;
  final int categoryId;
  final int modelId;
  final int userId;
  final int sellsCenter;
  final String model;
  final int visitorRef;
  final int roleRef;
  final int usersGroupRef;
  final int listViewDetailId;

  const DetailesStarted({
    required this.productId,
    required this.categoryId,
    required this.modelId,
    required this.userId,
    required this.sellsCenter,
    required this.model,
    required this.visitorRef,
    required this.roleRef,
    required this.usersGroupRef,
    required this.listViewDetailId,
  });
}

class DetailesLikeClickedButton extends DetailesEvent {
  String name;
  final int userRef;
  final int productId;
  final int commentRef;
  final int sellsCenter;
  final bool liked;

  DetailesLikeClickedButton({
    required this.name,
    required this.userRef,
    required this.productId,
    required this.sellsCenter,
    required this.liked,
    required this.commentRef,
  });
}

class DetailesIncrementClickedButton extends DetailesEvent {
  final int productId;
  final int value;

  DetailesIncrementClickedButton(this.productId, this.value);
}

class DetailesDecrementClickedButton extends DetailesEvent {
  final int productId;
  final int value;
  DetailesDecrementClickedButton(this.productId, this.value);
}

class DetailesAddToCartButtonClicked extends DetailesEvent {
  final int productId;
  final int count;
  final double price;
  final double takhfif;
  final double etebar;
  final int emtiaz;
  final int userId;
  final int dlRef;
  final int listViewDetailRef;
  final String productName;
  final int sellsCenterId;
  final int categoriesId;
  final int userGroupId;
  final int visitorId;
  final double lat;
  final double long;

  const DetailesAddToCartButtonClicked({
    required this.productId,
    required this.count,
    required this.price,
    required this.takhfif,
    required this.etebar,
    required this.emtiaz,
    required this.userId,
    required this.dlRef,
    required this.listViewDetailRef,
    required this.productName,
    required this.sellsCenterId,
    required this.categoriesId,
    required this.userGroupId,
    required this.visitorId,
    required this.lat,
    required this.long,
  });
}

class DetailAddToFavoriteButtonClicked extends DetailesEvent {
  final int productId;

  DetailAddToFavoriteButtonClicked(this.productId);
}
