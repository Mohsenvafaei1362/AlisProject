import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/details/details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 176,
    this.itemHeight = 170,
    this.property,
  }) : super(key: key);

  final ProductEntity product;
  final PropertyEntity? property;
  final BorderRadius borderRadius;
  final double itemWidth;
  final double itemHeight;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  StreamSubscription<ProductsState>? streamSubscription;
  final UiDl _dl = Get.put(UiDl());
  final UserInfo _userInfo = Get.put(UserInfo());
  bool isFavorite = true;
  ProductsBloc? productsBloc;
  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
    productsBloc?.close();
  }

  send() {
    productsBloc?.add(
      ProductSendLog(
        categoryId: widget.product.categoriesId,
        event: 'Start',
        model: 'ViewByList',
        modelId: 1,
        productId: widget.product.id,
        sellsCenter: _userInfo.sellsCenter.value,
        sourceTitle: 'MainPage',
        userId: _userInfo.UserId.value,
        // productId: widget.product.id,
        // title: 'detaile',
        // message: 'showdetaile',
        // sellsCenter: _userInfo.sellsCenter.value,
        // userId: _dl.UserId.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: BlocProvider<ProductsBloc>(
        create: (context) {
          final bloc = ProductsBloc(
            cartRepository: cartRepository,
            productRepository: productRepository,
          );
          productsBloc = bloc;
          bloc.add(const ProductStarted(''));
          streamSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  duration: Duration(seconds: 2),
                  content: Text('محصول با موفقیت اضافه شد'),
                ),
              );
            } else if (state is ProductAddToCartError) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     duration: const Duration(seconds: 1),
              //     content: Text(state.exception.message),
              //   ),
              // );
            } else if (state is ProductSendLogSuccess) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: DetailScreen(
                      productId: widget.product.id,
                      data: 1,
                    ),
                  ),
                ),
              );
            }
          });
          return bloc;
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            //  for (var element in widget.product.) {
            //   _avatarLevellst.add(
            //     base64.decode(
            //       element.img.toString(),
            //     ),
            //   );
            // }
            return SizedBox(
              width: size.width * 0.45,
              child: InkWell(
                onTap: () async {
                  // BlocProvider.of<ProductsBloc>(context).add(
                  //   ProductSendLog(widget.product.id, 'detaile', 'showdetaile'),
                  // );
                  await send();
                  // if (state is ProductSendLogSuccess) {
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => Directionality(
                  //         textDirection: TextDirection.rtl,
                  //         child: DetailScreen(
                  //           product: widget.product,
                  //           data: 1,
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: widget.borderRadius,
                  ),
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            right: 0,
                            left: 0,
                            child: ClipOval(
                              child: Container(
                                // width: size.width * 0.2,
                                height: size.height * 0.04,
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            // color: Colors.amber,
                            width: widget.itemWidth,
                            height: widget.itemHeight,
                            child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'image',
                                child: Image.memory(base64.decode(
                                  widget.product.imageUrl.toString(),
                                ))),
                          ),
                          Positioned(
                            top: 0,
                            right: 20,
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: IconButton(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                onPressed: () {
                                  // isFavorite = !isFavorite;
                                  if (!favoritmanager
                                      .isFavorite(widget.product)) {
                                    favoritmanager.addFavorite(widget.product);
                                  } else {
                                    favoritmanager.delete(widget.product);
                                  }
                                  setState(() {});
                                  // BlocProvider.of<ProductsBloc>(context).add(
                                  //   ProductAddToFavoriteButtonClicked(
                                  //     widget.product.id,
                                  //   ),
                                  // );
                                },
                                icon: Icon(
                                  favoritmanager.isFavorite(widget.product)
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  color:
                                      favoritmanager.isFavorite(widget.product)
                                          ? Colors.pink[300]
                                          : Colors.black38,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          widget.product.emtiaz != '0'
                              ? Positioned(
                                  top: 10,
                                  left: 20,
                                  child: Container(
                                      width: 32,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.pink[400],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        widget.product.emtiaz
                                            .toString()
                                            .toPersianDigit(),
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )),
                                )
                              : Text(''),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(widget.product.like.toPersianDigit()),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('قیمت : ${widget.product.price}'
                                          .toPersianDigit())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'امتیاز ریالی : ${widget.product.takhfif}'
                                              .toPersianDigit())
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'اعتبار شما : ${widget.product.etebar}'
                                              .toPersianDigit())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  widget.product.finalprice.toPersianDigit() +
                                      ' تومان ',
                                ),
                                // widget.product.discount != 0
                                //     ? Text(
                                //         '${(widget.product.price - (widget.product.price * (widget.product.discount / 100))).withPriceLable}'
                                //             .toPersianDigit(),
                                //       )
                                //     : Text(
                                //         widget.product.price.withPriceLable
                                //             .toPersianDigit(),
                                //       ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft,
                                  onPressed: () {
                                    // print(widget.product.title);
                                    // print(widget.product.id);
                                    BlocProvider.of<ProductsBloc>(context).add(
                                      ProductAddToCartButtonClicked(
                                          widget.product.id),
                                    );
                                  },
                                  icon: const Icon(
                                    CupertinoIcons.cart_badge_plus,
                                    color: Colors.green,
                                  ),
                                ),
                                // const Icon(
                                //   CupertinoIcons.cart_badge_plus,
                                //   color: Colors.green,
                                // ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
