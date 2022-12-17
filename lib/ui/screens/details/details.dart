import 'dart:async';

import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Comment/comment.dart';
import 'package:local_notification_flutter_project/ui/screens/Comment_Product/comment_product.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:local_notification_flutter_project/ui/screens/details/bloc/detailes_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ScrollPhysics.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/theme/theme.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DetailScreen extends StatefulWidget {
  final ProductEntity product;
  final int data;
  const DetailScreen({key, required this.product, required this.data});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StreamSubscription<ProductsState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  bool isFavorite = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const comment = Comment.comments;
    final priceFinal = widget.product.price -
        (widget.product.price * widget.product.discount / 100);
    return BlocProvider<DetailesBloc>(
      create: (context) {
        final bloc = DetailesBloc(
          productRepository: productRepository,
        );
        bloc.add(DetailesStarted(widget.data));
        return bloc;
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: BlocBuilder<DetailesBloc, DetailesState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.grey[200],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: SizedBox(
                width: size.width * 0.95,
                height: size.height * 0.08,
                child: FloatingActionButton.extended(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                  backgroundColor: const Color(0xfffafafa),
                  onPressed: () {},
                  label: state is ProductAddToCartBttonLoading
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                        )
                      : Container(
                          width: size.width * 0.95,
                          height: size.height * 0.08,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  BlocProvider.of<ProductsBloc>(context).add(
                                      ProductAddToCartButtonClicked(
                                          widget.product.id));
                                },
                                child: Container(
                                  width: size.width * 0.38,
                                  height: size.height * 0.06,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffef5350),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Center(
                                    child: Text('افزودن به سبد خرید'),
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   width: 50,
                              // ),
                              SizedBox(
                                width: size.width * 0.35,
                                height: size.height * 0.07,
                                // color: Color(0xffffa34d),
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        widget.product.discount != 0
                                            ? Container(
                                                width: size.width * 0.1,
                                                height: size.height * 0.03,
                                                padding:
                                                    const EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Center(
                                                  child: Text(
                                                    '${widget.product.discount.toString().withDiscountLable}'
                                                        .toPersianDigit(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const Text(''),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Row(
                                          children: [
                                            widget.product.discount != 0
                                                ? Text(
                                                    widget.product.price
                                                        .withPriceLable
                                                        .toPersianDigit(),
                                                    style: const TextStyle(
                                                      color: Colors.black38,
                                                      fontSize: 12,
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                    ),
                                                  )
                                                : const Text(''),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          priceFinal.withPriceLable
                                              .toPersianDigit(),
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              body: SafeArea(
                child: CustomScrollView(
                  physics: defaultScrollPhysics,
                  slivers: [
                    SliverAppBar(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(120),
                          bottomRight: Radius.circular(2),
                        ),
                      ),
                      expandedHeight: MediaQuery.of(context).size.width,
                      flexibleSpace: ImageLoadingService(
                        imageUrl: widget.product.imageUrl,
                        width: size.width,
                      ),
                      foregroundColor: LightThemeColors.primaryTextColors,
                      backgroundColor: Colors.white,
                      actions: [
                        IconButton(
                          splashColor: Colors.white,
                          highlightColor: Colors.white,
                          onPressed: () {
                            if (!favoritmanager.isFavorite(widget.product)) {
                              favoritmanager.addFavorite(widget.product);
                            } else {
                              favoritmanager.delete(widget.product);
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            favoritmanager.isFavorite(widget.product)
                                ? CupertinoIcons.heart_fill
                                : CupertinoIcons.heart,
                            color: favoritmanager.isFavorite(widget.product)
                                ? Colors.pink[300]
                                : Colors.black38,
                            size: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: -3,
                                right: -2,
                                child: Badge(
                                  badgeContent: Text(
                                    widget.data.toString().toPersianDigit(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: CartScreen(),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(CupertinoIcons.cart),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: size.width,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  padding: const EdgeInsets.all(32.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 1,
                                    ),
                                    // color: Colors.yellow,
                                    // color: Colors.white.withOpacity(0.9),
                                    // borderRadius: BorderRadius.circular(30),
                                    // BorderRadius.only(
                                    //   topLeft: Radius.circular(30),
                                    //   topRight: Radius.circular(30),
                                    // ),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.product.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.star_fill,
                                            color: Colors.amber,
                                            size: 10,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${widget.product.discount}'
                                                .toPersianDigit(),
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'دیدگاه کاربران',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue[200],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            'پرسش و پاسخ',
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.blue[200],
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            CupertinoIcons.hand_thumbsup,
                                            color: Colors.green,
                                            size: 15,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(
                                            '92% (870 نفر) از خریداران این کالا را پیشنهاد کرده اند'
                                                .toPersianDigit(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // margin:
                                  //     const EdgeInsets.only(bottom: 5, top: 5),
                                  padding: const EdgeInsets.all(32),
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    // color: Colors.yellow,
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text('شعبه'),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'شعبه مرکزی',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black26,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                'موجود در انبار',
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.black26,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text('پروموشن ها'),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'در صورت خرید 4 عدد به بالا 3% تخفیف دریافت می کنید'
                                                .toPersianDigit(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 11,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'در صورت خرید 4 عدد به بالا 100  امتیاز دریافت می کنید'
                                                .toPersianDigit(),
                                            style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 11,
                                            ),
                                          ),
                                          const Divider(
                                            color: Colors.black26,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'در صورت خرید یکی از کالاهای زیر به همراه این کالا 100 امتیاز دریافت می کنید'
                                                  .toPersianDigit(),
                                              style: const TextStyle(
                                                color: Colors.black54,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.black26,
                                      ),
                                      const Text(
                                        'محصولات مشابه',
                                        style: TextStyle(),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                PropertyProduct(size: size), //ویژگی محصول
                                UserOpinion(
                                    size: size,
                                    comment: comment), //دیدگاه کاربران
                                MyView(size: size), //دیدگاه خود
                                Container(
                                  width: size.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(32.0),
                                  // color: Colors.white,
                                ),
                              ],
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

class MyView extends StatelessWidget {
  const MyView({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: Comment_Product(),
            ),
          ),
        );
        // Get.to(() => Directionality(
        //     textDirection: TextDirection.rtl, child: Comment_Product()));
      },
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(32.0),
        color: Colors.grey[100],
        child: Row(
          children: [
            const Icon(CupertinoIcons.chat_bubble),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'دیدگاه خود را درباره این کالا بنویسید',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                Text(
                  '10 امتیاز عالیس'.toPersianDigit(),
                  style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38),
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chevron_back,
              color: Colors.black54,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class UserOpinion extends StatelessWidget {
  const UserOpinion({
    Key? key,
    required this.size,
    required this.comment,
  }) : super(key: key);

  final Size size;
  final List<Comment> comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(32.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text('دیدگاه کاربران'),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: size.height * 0.12,
            // color: Colors.red,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comment.length,
              itemBuilder: (context, index) {
                final dataComment = comment[index];
                return Column(
                  children: [
                    Container(
                      // width: size.width * 0.5,
                      // height: size.height * 0.18,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Color(0xffbdbdbd),
                        //     spreadRadius: 1,
                        //     blurRadius: 1,
                        //     offset: Offset(0,
                        //         1), // changes position of shadow
                        //   ),
                        // ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataComment.title,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            dataComment.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PropertyProduct extends StatelessWidget {
  const PropertyProduct({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(32.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ویژگی های محصول'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'نوع رایحه : ',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' لیمو ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      'حجم : ',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                    // Text(
                    //   '${detalilsProduct.map['Size']}'
                    //       .toPersianDigit(),
                    //   style: TextStyle(
                    //     color: Colors.black87,
                    //     fontSize: 12,
                    //   ),
                    // ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      'سی سی'.toPersianDigit(),
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Text(
                      'ویژگی : ',
                      style: TextStyle(
                        color: Colors.black38,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      ' بدون الکل ',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
