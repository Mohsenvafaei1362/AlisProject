import 'dart:async';

import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/details/details.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class ProductSearch extends StatefulWidget {
  const ProductSearch({
    Key? key,
    required this.product,
    required this.borderRadius,
    this.itemWidth = 150,
    this.itemHeight = 160,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;
  final double itemWidth;
  final double itemHeight;

  @override
  State<ProductSearch> createState() => _ProductSearchState();
}

class _ProductSearchState extends State<ProductSearch> {
  StreamSubscription<ProductsState>? streamSubscription;
  bool isFavorite = true;
  @override
  void dispose() {
    super.dispose();
    streamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return InkWell(
      borderRadius: widget.borderRadius,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: DetailScreen(
                product: widget.product,
                data: 1,
              ),
            ),
          ),
        );
      },
      child: BlocProvider<ProductsBloc>(
        create: (context) {
          final bloc = ProductsBloc(
              cartRepository: cartRepository,
              productRepository: productRepository);
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 1),
                  content: Text(state.exception.message),
                ),
              );
            }
          });
          return bloc;
        },
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return Container(
              width: widget.itemWidth,
              height: widget.itemHeight,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: widget.borderRadius,
              ),
              // margin: const EdgeInsets.all(5),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 3,
                child: Row(
                  children: [
                    Container(
                      width: widget.itemWidth,
                      height: widget.itemHeight,
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                      // color: Colors.amber,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.product.productname,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('5'),
                            ],
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.product.price.withPriceLable
                                    .toPersianDigit(),
                              ),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: widget.itemWidth,
                        height: widget.itemHeight,
                        // color: Colors.red,
                        alignment: Alignment.bottomLeft,
                        child: Stack(
                          children: [
                            SizedBox(
                              // color: Colors.amber,
                              width: widget.itemWidth,
                              height: widget.itemHeight,
                              child: Hero(
                                transitionOnUserGestures: true,
                                tag: 'image',
                                child: ImageLoadingService(
                                  imageUrl: widget.product.productimg,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 0,
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
                                    setState(() {
                                      isFavorite = !isFavorite;
                                      BlocProvider.of<ProductsBloc>(context)
                                          .add(
                                        ProductAddToFavoriteButtonClicked(
                                          widget.product.id,
                                        ),
                                      );
                                    });
                                  },
                                  icon: Icon(
                                    isFavorite
                                        ? CupertinoIcons.heart
                                        : CupertinoIcons.heart_fill,
                                    color: isFavorite
                                        ? Colors.black87
                                        : Colors.pink[300],
                                    size: 24,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
