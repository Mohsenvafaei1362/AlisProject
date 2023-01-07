import 'dart:async';
import 'dart:convert';

import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/CommentProduct.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/promotion_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Comment_Product/comment_product.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:local_notification_flutter_project/ui/screens/details/bloc/detailes_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/details/promotionText.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ScrollPhysics.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/theme/theme.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class DetailScreen extends StatefulWidget {
  final int listViewDetailId;
  final int pid;

  final int data;
  final double itemWidth;
  final double itemHeight;
  const DetailScreen({
    key,
    required this.listViewDetailId,
    required this.data,
    this.itemWidth = 176,
    this.itemHeight = 170,
    required this.pid,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  StreamSubscription<ProductsState>? stateSubscription;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  final ImageDetaile _imagedetaile = Get.put(ImageDetaile());
  final UiGetLocation getLocation = Get.put(UiGetLocation());
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
  final PageController _controller = PageController();

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
                // onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                //     builder: ((context) => Detail(
                //           product: widget.product,
                //           data: 1,
                //         )))),
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  int count = 1;
  final UserInfo _userInfo = Get.put(UserInfo());
  final UiDl _dl = Get.put(UiDl());

  String productsimilar = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // const comment = Comment.comments_ab;
    // final priceFinal = widget.product.price -
    //     (widget.product.price * widget.product.discount / 100);
    return WillPopScope(
      onWillPop: () async {
        print('object');
        // return _onWillPop();
        return Future.value(true);
      },
      child: BlocProvider<DetailesBloc>(
        create: (context) {
          final bloc = DetailesBloc(
            productRepository: productRepository,
            promotionRepository: promotionRepository,
            cartRepository: cartRepository,
          );
          bloc.add(DetailesStarted(
            listViewDetailId: widget.listViewDetailId,
            sellsCenter: _userInfo.sellsCenter.value,
            productId: widget.pid,
            categoryId: 0,
            model: '',
            modelId: 0,
            roleRef: _userInfo.RoleId.value,
            userId: _userInfo.UserId.value,
            usersGroupRef: _userInfo.userGroups.value,
            visitorRef: _userInfo.visitor.value,
          ));
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: BlocBuilder<DetailesBloc, DetailesState>(
            builder: (context, state) {
              if (state is DetailesSuccess) {
                return Scaffold(
                  backgroundColor: Color.fromARGB(255, 238, 238, 238),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerFloat,
                  floatingActionButton: FloatingActionButton.extended(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                    label: state is ProductAddToCartBttonLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : Container(
                            width: size.width,
                            height: size.height * 0.08,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<DetailesBloc>(context).add(
                                      DetailesAddToCartButtonClicked(
                                        count: count,
                                        emtiaz: int.parse(
                                            state.productDetail.first.emtiaz),
                                        etebar: double.parse(
                                            state.productDetail.first.etebar),
                                        price: state.productDetail.first.price,
                                        productId:
                                            state.productDetail.first.productId,
                                        takhfif: double.parse(
                                            state.productDetail.first.takhfif),
                                        userId: _userInfo.UserId.value,
                                        categoriesId: state
                                            .productDetail.first.categoriesId,
                                        dlRef: _dl.DlId.value,
                                        listViewDetailRef:
                                            widget.listViewDetailId,
                                        productName:
                                            state.productDetail.first.title,
                                        sellsCenterId:
                                            _userInfo.sellsCenter.value,
                                        userGroupId: _userInfo.userGroups.value,
                                        visitorId: _userInfo.visitor.value,
                                        lat: getLocation.lat.value,
                                        long: getLocation.long.value,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: size.width * 0.38,
                                    height: size.height * 0.06,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffEB455F),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Center(
                                      child: Text(
                                        'افزودن به سبد خرید',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (count > 1) {
                                          setState(() {
                                            --count;
                                          });
                                          // BlocProvider.of<DetailesBloc>(context)
                                          //     .add(
                                          //   DetailesDecrementClickedButton(
                                          //     widget.productId,
                                          //     count,
                                          //   ),
                                          // );
                                        }
                                      },
                                      child: Icon(
                                        CupertinoIcons.minus_rectangle,
                                        color: Colors.red,
                                        size: 20,
                                      ),
                                    ),
                                    count == 0
                                        ? Text('')
                                        : Text(
                                            count.toString().toPersianDigit(),
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          ++count;
                                        });
                                        // BlocProvider.of<DetailesBloc>(context)
                                        //     .add(
                                        //   DetailesIncrementClickedButton(
                                        //     widget.productId,
                                        //     count,
                                        //   ),
                                        // );
                                      },
                                      child: Icon(
                                        CupertinoIcons.plus_rectangle,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(
                                //     CupertinoIcons.minus_rectangle,
                                //     color: Colors.red,
                                //   ),
                                // ),
                                // IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(
                                //     CupertinoIcons.plus_rectangle,
                                //     color: Colors.green,
                                //   ),
                                // ),
                                SizedBox(
                                  width: size.width * 0.35,
                                  height: size.height * 0.07,
                                  // color: Color(0xffffa34d),
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (state.productDetail.first
                                                  .takhfif !=
                                              '0')
                                            Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.03,
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  color: Color(0xffEB455F),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  '${state.productDetail.first.takhfif.toString().withDiscountLable}'
                                                      .toPersianDigit(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Row(
                                            children: [
                                              if (state.productDetail.first
                                                      .takhfif !=
                                                  '0')
                                                Text(
                                                  state
                                                      .productDetail
                                                      .first
                                                      .price
                                                      .withPriceLableDouble
                                                      .toPersianDigit(),
                                                  style: const TextStyle(
                                                    color: Color(0xff3C4048),
                                                    fontSize: 12,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            state.productDetail.first.finalprice
                                                .toPersianDigit()
                                                .seRagham(),
                                            style: const TextStyle(
                                              color: Color(0xff3C4048),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
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
                          flexibleSpace: Image.memory(
                            base64.decode(
                              state.productDetail.first.imageUrl,
                            ),
                          ),
                          foregroundColor: LightThemeColors.primaryTextColors,
                          backgroundColor: Colors.white,
                          actions: [
                            IconButton(
                              splashColor: Colors.white,
                              highlightColor: Colors.white,
                              onPressed: () {
                                BlocProvider.of<DetailesBloc>(context).add(
                                  DetailAddToFavoriteButtonClicked(
                                    state.productDetail.first.productId,
                                  ),
                                );
                              },
                              icon: Icon(
                                favoritmanager
                                        .isFavorite(state.productDetail.first)
                                    ? CupertinoIcons.heart_fill
                                    : CupertinoIcons.heart,
                                color: favoritmanager
                                        .isFavorite(state.productDetail.first)
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
                                    icon: const Icon(
                                      CupertinoIcons.cart,
                                      color: Colors.black38,
                                    ),
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
                                        color: Colors.white,
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
                                                state.productDetail.first.title,
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
                                                '${state.productDetail.first.emtiaz} امتیاز دریافت می کنید'
                                                    .toPersianDigit(),
                                                style: const TextStyle(
                                                  fontSize: 12,
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
                                                '92% (${state.productDetail.first.like} نفر) از خریداران این کالا را پیشنهاد کرده اند'
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
                                      padding: const EdgeInsets.all(16),
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          state.similar.length != 0
                                              ? Text(
                                                  'پروموشن ها',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54,
                                                  ),
                                                )
                                              : Text(''),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: size.width,
                                            // height: size.height * 0.2,
                                            height: 50 *
                                                state.similar.length.toDouble(),
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  blurRadius: 2,
                                                )
                                              ],
                                              border: Border.all(
                                                color: Colors.black26,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: ListView.builder(
                                                    itemCount:
                                                        state.similar.length,
                                                    // itemCount: 10,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final data =
                                                          state.similar[index];
                                                      return Container(
                                                        child: Text(
                                                          data.text,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            height: 2.5,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   state.similar.first.text,
                                                //   style: TextStyle(
                                                //     height: 2,
                                                //   ),
                                                // ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        PromotionText(
                                                                          promotion:
                                                                              state.similar,
                                                                        )));
                                                      },
                                                      child: Text(
                                                        'بیشتر بخوانید',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.blue,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              // Text(
                                              //   'در صورت خرید 4 عدد به بالا 3% تخفیف دریافت می کنید'
                                              //       .toPersianDigit(),
                                              //   style: const TextStyle(
                                              //     color: Colors.black54,
                                              //     fontSize: 11,
                                              //   ),
                                              // ),
                                              // const SizedBox(
                                              //   height: 10,
                                              // ),
                                              // Text(
                                              //   'در صورت خرید 4 عدد به بالا 100  امتیاز دریافت می کنید'
                                              //       .toPersianDigit(),
                                              //   style: const TextStyle(
                                              //     color: Colors.black54,
                                              //     fontSize: 11,
                                              //   ),
                                              // ),
                                              // const Divider(
                                              //   color: Colors.black26,
                                              // ),
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
                                            height: size.height * 0.5,
                                            // color: Colors.grey[200],
                                            child: ListView.builder(
                                              itemCount: state.similar.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                final data =
                                                    state.similar[index];

                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: ((context) =>
                                                            DetailScreen(
                                                              listViewDetailId:
                                                                  data.id,
                                                              data: 1,
                                                              pid: data
                                                                  .productId,
                                                            )),
                                                      ),
                                                    );
                                                  },
                                                  child: SizedBox(
                                                    width: size.width * 0.45,
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color:
                                                                Colors.white70,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      elevation: 5,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              Positioned(
                                                                bottom: 0,
                                                                right: 0,
                                                                left: 0,
                                                                child: ClipOval(
                                                                  child:
                                                                      Container(
                                                                    // width: size.width * 0.2,
                                                                    height: size
                                                                            .height *
                                                                        0.04,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          100],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                // color: Colors.amber,
                                                                width: widget
                                                                    .itemWidth,
                                                                height: widget
                                                                    .itemHeight,
                                                                child: Image
                                                                    .memory(base64
                                                                        .decode(
                                                                  data.imageUrl
                                                                      .toString(),
                                                                )),
                                                              ),
                                                              Positioned(
                                                                top: 0,
                                                                right: 20,
                                                                child:
                                                                    Container(
                                                                  width: 32,
                                                                  height: 32,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child:
                                                                      IconButton(
                                                                    splashColor:
                                                                        Colors
                                                                            .white,
                                                                    highlightColor:
                                                                        Colors
                                                                            .white,
                                                                    onPressed:
                                                                        () {
                                                                      BlocProvider.of<DetailesBloc>(
                                                                              context)
                                                                          .add(
                                                                        DetailAddToFavoriteButtonClicked(
                                                                          data.id,
                                                                        ),
                                                                      );
                                                                    },
                                                                    icon: Icon(
                                                                      favoritmanager.isFavorite(state
                                                                              .productDetail
                                                                              .first)
                                                                          ? CupertinoIcons
                                                                              .heart_fill
                                                                          : CupertinoIcons
                                                                              .heart,
                                                                      color: favoritmanager.isFavorite(state
                                                                              .productDetail
                                                                              .first)
                                                                          ? Colors.pink[
                                                                              300]
                                                                          : Colors
                                                                              .black38,
                                                                      size: 24,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              state.productDetail.first
                                                                          .emtiaz !=
                                                                      '0'
                                                                  ? Positioned(
                                                                      top: 10,
                                                                      left: 20,
                                                                      child: Container(
                                                                          width: 32,
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.pink[400],
                                                                            borderRadius:
                                                                                BorderRadius.all(
                                                                              Radius.circular(10),
                                                                            ),
                                                                          ),
                                                                          child: Text(
                                                                            state.productDetail.first.emtiaz.toString().toPersianDigit(),
                                                                            style:
                                                                                TextStyle(
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
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 10,
                                                                    left: 10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  state
                                                                      .productDetail
                                                                      .first
                                                                      .title,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                                Row(
                                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Colors
                                                                          .amber,
                                                                      size: 15,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                    Text(state
                                                                        .productDetail
                                                                        .first
                                                                        .like
                                                                        .toPersianDigit()),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          100],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        children: [
                                                                          Text('قیمت : ${state.productDetail.first.price}'
                                                                              .toPersianDigit())
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text('امتیاز ریالی : ${state.productDetail.first.takhfif}'
                                                                              .toPersianDigit())
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text('اعتبار شما : ${state.productDetail.first.etebar}'
                                                                              .toPersianDigit())
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      state.productDetail.first
                                                                              .finalprice
                                                                              .toPersianDigit() +
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
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      onPressed:
                                                                          () {
                                                                        // print(widget.product.title);
                                                                        // print(widget.product.id);
                                                                        BlocProvider.of<ProductsBloc>(context)
                                                                            .add(
                                                                          ProductAddToCartButtonClicked(
                                                                            state.productDetail.first.id,
                                                                            count,
                                                                          ),
                                                                        );
                                                                      },
                                                                      icon:
                                                                          const Icon(
                                                                        CupertinoIcons
                                                                            .cart_badge_plus,
                                                                        color: Colors
                                                                            .green,
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
                                          const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),

                                    PropertyProduct(
                                      size: size,
                                      property: state.property,
                                    ),
                                    //ویژگی محصول
                                    UserOpinion(
                                      size: size,
                                      comment: state.comment,
                                      product: state.productDetail.first,
                                    ), //دیدگاه کاربران
                                    MyView(size: size), //دیدگاه خود
                                    Container(
                                      width: size.width,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
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
        color: Colors.white,
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
    required this.product,
  }) : super(key: key);

  final Size size;
  final List<CommentProduct> comment;
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    if (comment.length != 0) {
      return Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 0),
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
                scrollDirection: Axis.vertical,
                itemCount: comment.length,
                itemBuilder: (context, index) {
                  final dataComment = comment[index];
                  return Column(
                    children: [
                      SizedBox(
                        width: size.width * 0.9,
                        height: size.height * 0.2,
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
                          child: Container(
                            width: size.width * 0.3,
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Color(0xffEEEEEE),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Color(0xffD6E4E5),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 0,
                                  // spreadRadius: 1,
                                  // blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            // elevation: 3,
                            // color: Colors.white.withOpacity(0.95),
                            // shape: RoundedRectangleBorder(
                            //   side: BorderSide(
                            //     color: Colors.black12,
                            //     width: 1,
                            //   ),
                            //   borderRadius: BorderRadius.circular(10),
                            // ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataComment.name,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    dataComment.comment,
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      height: 2.1,
                                      fontSize: 10,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        height: size.height * 0.035,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            final UiDl _dl = Get.put(UiDl());
                                            final UserInfo _userInfo =
                                                Get.put(UserInfo());
                                            BlocProvider.of<DetailesBloc>(
                                                    context)
                                                .add(
                                              DetailesLikeClickedButton(
                                                name: _dl.FullName.value,
                                                userRef: _userInfo.UserId.value,
                                                productId: product.id,
                                                sellsCenter:
                                                    _userInfo.sellsCenter.value,
                                                liked: true,
                                                commentRef: dataComment.id,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'می پسندم',
                                            style: TextStyle(
                                              // color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.035,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.pink[300],
                                          ),
                                          onPressed: () {
                                            final UiDl _dl = Get.put(UiDl());
                                            final UserInfo _userInfo =
                                                Get.put(UserInfo());
                                            BlocProvider.of<DetailesBloc>(
                                                    context)
                                                .add(
                                              DetailesLikeClickedButton(
                                                name: _dl.FullName.value,
                                                userRef: _userInfo.UserId.value,
                                                productId: product.id,
                                                sellsCenter:
                                                    _userInfo.sellsCenter.value,
                                                liked: false,
                                                commentRef: dataComment.id,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'نمی پسندم',
                                            style: TextStyle(
                                              // color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        'نفر پسندیده اند : ${dataComment.countlike.toString()}'
                                            .toPersianDigit(),
                                      ),
                                    ],
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
    } else {
      return Container();
    }
  }
}

class PropertyProduct extends StatelessWidget {
  const PropertyProduct({
    Key? key,
    required this.size,
    required this.property,
  }) : super(key: key);

  final Size size;
  final List<PropertyEntity> property;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: size.width,
    //   margin: const EdgeInsets.symmetric(vertical: 5),
    //   padding: const EdgeInsets.all(32.0),
    //   color: Colors.white,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       const Text('ویژگی های محصول'),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             Row(
    //               children: const [
    //                 Text(
    //                   'تیتر1 : ',
    //                   style: TextStyle(
    //                     color: Colors.black38,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 Text(
    //                   ' لیمو ',
    //                   style: TextStyle(
    //                     color: Colors.black87,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 15,
    //             ),
    //             Row(
    //               children: [
    //                 const Text(
    //                   'حجم : ',
    //                   style: TextStyle(
    //                     color: Colors.black38,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 // Text(
    //                 //   '${detalilsProduct.map['Size']}'
    //                 //       .toPersianDigit(),
    //                 //   style: TextStyle(
    //                 //     color: Colors.black87,
    //                 //     fontSize: 12,
    //                 //   ),
    //                 // ),
    //                 const SizedBox(
    //                   width: 3,
    //                 ),
    //                 Text(
    //                   'سی سی'.toPersianDigit(),
    //                   style: const TextStyle(
    //                     color: Colors.black87,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             const SizedBox(
    //               height: 15,
    //             ),
    //             Row(
    //               children: const [
    //                 Text(
    //                   'ویژگی : ',
    //                   style: TextStyle(
    //                     color: Colors.black38,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //                 Text(
    //                   ' بدون الکل ',
    //                   style: TextStyle(
    //                     color: Colors.black87,
    //                     fontSize: 12,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      width: size.width,
      // height: size.height * 0.25,
      height: 48 * property.length.toDouble(),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 3, 12, 3),
                child: Text(
                  'ویژگی محصول',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: property.length,
              // itemCount: 10,
              itemBuilder: (context, index) {
                final data = property[index];
                return Container(
                  padding: EdgeInsets.fromLTRB(12, 5, 12, 5),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    // color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.newTitle),
                      // Text('titr2'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
