class AddToCartResponse {
  final int productid;
  final int cartItemId;
  final int count;

  AddToCartResponse(this.productid, this.cartItemId, this.count);

  AddToCartResponse.fromJson(Map<String, dynamic> json)
      : productid = json['product_id'],
        cartItemId = json['cartItem_id'],
        count = json['count'];
}
