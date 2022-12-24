import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
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
  final List<SliderInfo>? images;
  const DetailScreen(
      {key, required this.product, required this.data, this.images});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StreamSubscription<ProductsState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  final ImageDetaile _imagedetaile = Get.put(ImageDetaile());
  @override
  void dispose() {
    stateSubscription?.cancel();
    _scaffoldKey.currentState?.dispose();
    super.dispose();
  }

  String _imageUrl = '';
  bool isFavorite = true;
  var comment;
  var property;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if (widget.product.id == 1) {
    //   comment = Comment.comments_milkt;
    // }
    switch (widget.product.id) {
      case 1:
        comment = Comment.comments_milkt;

        break;
      case 2:
        comment = Comment.comments_milk;
        break;
      case 3:
        comment = Comment.comments_milkt;
        break;
      case 4:
        comment = Comment.comments_dogh;
        break;
      case 5:
        comment = Comment.comments_dogh;
        break;
      case 6:
        comment = Comment.comments_dogh;
        break;
      case 7:
        comment = Comment.comments_dogh;
        break;
      case 8:
        comment = Comment.comments_abmive;
        break;
      case 9:
        comment = Comment.comments_abmive;
        break;
      case 10:
        comment = Comment.comments_ab;
        break;
      case 11:
        comment = Comment.comments_delester;
        break;
      case 12:
        comment = Comment.comments_noshabe;
        break;
      case 13:
        comment = Comment.comments_abghazt;
        break;
      default:
    }
    // const comment = Comment.comments_ab;
    final priceFinal = widget.product.price -
        (widget.product.price * widget.product.discount / 100);
    return BlocProvider<DetailesBloc>(
      create: (context) {
        final bloc = DetailesBloc(
          productRepository: productRepository,
        );
        bloc.add(DetailesStarted(widget.data, widget.product.id));
        return bloc;
      },
      child: ScaffoldMessenger(
        key: _scaffoldKey,
        child: BlocBuilder<DetailesBloc, DetailesState>(
          builder: (context, state) {
            if (state is DetailesSuccess) {
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
                                                    )
                                                  : const Text(''),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.4,
                        flexibleSpace: ImageLoadingService(
                          imageUrl: _imageUrl.length != 0
                              ? _imageUrl
                              : widget.product.imageUrl,
                          boxfit: BoxFit.none,
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
                                  // Container(
                                  //   width: size.width * 0.95,
                                  //   height: size.height * 0.12,
                                  //   // color: Colors.amber,
                                  //   child: ListView.builder(
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount:
                                  //         _imagedetaile.imagedetaile.length,
                                  //     itemBuilder: (context, index) {
                                  //       List<Uint8List> _banners = [];
                                  //       for (var element
                                  //           in _imagedetaile.imagedetaile) {
                                  //         _banners.add(
                                  //           base64.decode(
                                  //             element.img.toString(),
                                  //           ),
                                  //         );
                                  //       }
                                  //       final data =
                                  //           _imagedetaile.imagedetaile[index];
                                  //       return InkWell(
                                  //         onTap: () {
                                  //           setState(() {
                                  //             if (index == 0) {
                                  //               _imageUrl =
                                  //                   widget.product.imageUrl;
                                  //             } else {
                                  //               _imageUrl = data.img;
                                  //             }
                                  //           });
                                  //         },
                                  //         child: index == 0
                                  //             ? Container(
                                  //                 width: size.width * 0.25,
                                  //                 height: size.height,
                                  //                 decoration: BoxDecoration(
                                  //                   color: Colors.white,
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(8),
                                  //                 ),
                                  //                 margin: EdgeInsets.all(2),
                                  //                 padding: EdgeInsets.all(2),
                                  //                 child: Center(
                                  //                   child: ImageLoadingService(
                                  //                     imageUrl:
                                  //                         widget.product.imageUrl,
                                  //                   ),
                                  //                 ),
                                  //               )
                                  //             : Container(
                                  //                 width: size.width * 0.25,
                                  //                 height: size.height,
                                  //                 decoration: BoxDecoration(
                                  //                   color: Colors.white,
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(8),
                                  //                 ),
                                  //                 margin: EdgeInsets.all(2),
                                  //                 padding: EdgeInsets.all(2),
                                  //                 child: ClipRRect(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(10),
                                  //                   child: Image.memory(
                                  //                     _banners[index],
                                  //                     fit: BoxFit.cover,
                                  //                     width: size.width,
                                  //                     height: size.height,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //       );
                                  //     },
                                  //   ),
                                  // ),

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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                        Container(
                                          width: size.width,
                                          height: size.height * 0.25,
                                          // color: Colors.grey[200],
                                          child: ListView.builder(
                                            itemCount: state.similar.length,
                                            //  state.similar
                                            //     .where((e) => e.title.contains(
                                            //         widget.product.title))
                                            //     .map((e) => e)
                                            //     .toList()
                                            //     .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              // final d = state.similar
                                              //     .where((e) => e.title
                                              //         .contains(
                                              //             widget.product.title))
                                              //     .map((e) => e)
                                              //     .toList();
                                              // final data1 = d[index];
                                              final data = state.similar[index];

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: ((context) =>
                                                          DetailScreen(
                                                              product: data,
                                                              data: 1)),
                                                    ),
                                                  );
                                                },
                                                child: SizedBox(
                                                  width: size.width * 0.3,
                                                  child: Card(
                                                    elevation: 2,
                                                    margin: EdgeInsets.all(5),
                                                    color: Colors.grey[100],
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .fromLTRB(5, 5, 5, 8),
                                                      child: Column(
                                                        children: [
                                                          ImageLoadingService(
                                                            imageUrl:
                                                                data.imageUrl,
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            data.title,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            data.price
                                                                .withPriceLableString
                                                                .toPersianDigit(),
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
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
                                    comment: comment,
                                  ), //دیدگاه کاربران
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
            } else if (state is DetailesLoading) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (state is DetailesError) {
              return Center(
                child: Text(state.exception.message),
              );
            } else {
              throw Exception('state is not support');
            }
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
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.only(
                  right: 10,
                ),
                child: Text(
                  'دیدگاه کاربران',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: size.width,
            height: size.height * 0.2,
            // color: Colors.red,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: comment.length,
              itemBuilder: (context, index) {
                final dataComment = comment[index];
                return Column(
                  children: [
                    SizedBox(
                      width: size.width * 0.4,
                      height: size.height * 0.18,
                      child: InkWell(
                        onTap: () {
                          // Get.defaultDialog(
                          //   title: dataComment.title,
                          //   titleStyle: TextStyle(
                          //     color: Colors.black54,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          //   backgroundColor: Colors.grey[50],
                          //   content: Text(
                          //     dataComment.description,
                          //     textAlign: TextAlign.justify,
                          //     textDirection: TextDirection.rtl,
                          //     style: TextStyle(
                          //       fontSize: 12,
                          //       height: 2,
                          //     ),
                          //   ),
                          // );
                        },
                        child: Card(
                          elevation: 3,
                          color: Colors.white.withOpacity(0.95),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dataComment.title,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  dataComment.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    height: 2.1,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
