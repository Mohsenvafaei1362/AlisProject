import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Comment/comment.dart';
import 'package:local_notification_flutter_project/ui/screens/Comment_Product/comment_product.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:local_notification_flutter_project/ui/screens/details/bloc/detailes_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/details/details.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:badges/badges.dart';

class Detail extends StatefulWidget {
  const Detail({key, required this.product, required this.data, this.images});
  final ProductEntity product;
  final int data;
  final List<SliderInfo>? images;
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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

  final PageController _controller = PageController();
  String productsimilar = '';
  var comment;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final priceFinal = widget.product.price -
        (widget.product.price * widget.product.discount / 100);
    switch (widget.product.id) {
      case 1:
        comment = Comment.comments_milkt;
        setState(() {
          productsimilar = 'شیر';
        });
        break;
      case 2:
        comment = Comment.comments_milk;
        setState(() {
          productsimilar = 'شیر';
        });
        break;
      case 3:
        comment = Comment.comments_milkt;
        setState(() {
          productsimilar = 'شیر';
        });
        break;
      case 4:
        comment = Comment.comments_dogh;
        setState(() {
          productsimilar = 'دوغ';
        });
        break;
      case 5:
        comment = Comment.comments_dogh;
        setState(() {
          productsimilar = 'دوغ';
        });
        break;
      case 6:
        comment = Comment.comments_dogh;
        setState(() {
          productsimilar = 'دوغ';
        });
        break;
      case 7:
        comment = Comment.comments_dogh;
        setState(() {
          productsimilar = 'دوغ';
        });
        break;
      case 8:
        comment = Comment.comments_abmive;
        setState(() {
          productsimilar = 'نکتار';
        });
        break;
      case 9:
        comment = Comment.comments_abmive;
        setState(() {
          productsimilar = 'نکتار';
        });
        break;
      case 10:
        comment = Comment.comments_ab;
        setState(() {
          productsimilar = 'آب معدنی';
        });
        break;
      case 11:
        comment = Comment.comments_delester;
        setState(() {
          productsimilar = 'ماءالشعیر';
        });
        break;
      case 12:
        comment = Comment.comments_noshabe;
        setState(() {
          productsimilar = 'نوشابه';
        });
        break;
      case 13:
        comment = Comment.comments_abghazt;
        setState(() {
          productsimilar = "آبمیوه گازدار تشریفاتی";
        });
        break;
      default:
    }
    return WillPopScope(
      onWillPop: () {
        return _onWillPop();
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider<DetailesBloc>(
          create: (context) {
            final bloc = DetailesBloc(
              productRepository: productRepository,
            );
            bloc.add(DetailesStarted(widget.data, widget.product.id));
            return bloc;
          },
          child: BlocBuilder<DetailesBloc, DetailesState>(
            builder: (context, state) {
              if (state is DetailesSuccess) {
                final d = state.similar
                    .where((element) => element.title.contains(productsimilar));
                final f = d.map((e) => e).toList();
                print(f);
                return Scaffold(
                    backgroundColor: Colors.grey[300],
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      // BlocProvider.of<ProductsBloc>(context).add(
                                      //     ProductAddToCartButtonClicked(
                                      //         widget.product.id));
                                    },
                                    child: Container(
                                      width: size.width * 0.38,
                                      height: size.height * 0.06,
                                      padding: const EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: const Color(0xff00ABB3),
                                          borderRadius:
                                              BorderRadius.circular(5)),
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
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          if (widget.product.discount != 0)
                                            Container(
                                              width: size.width * 0.1,
                                              height: size.height * 0.03,
                                              padding: const EdgeInsets.all(0),
                                              decoration: BoxDecoration(
                                                  color: Color(0xff00ABB3),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                  '${widget.product.discount.toString().withDiscountLable}'
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
                                              if (widget.product.discount != 0)
                                                Text(
                                                  widget.product.price
                                                      .withPriceLable
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
                                            priceFinal.withPriceLable
                                                .toPersianDigit(),
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
                                  // if (widget.product.discount != 0)
                                  //   Text(
                                  //     widget.product.price.withPriceLable
                                  //         .toPersianDigit(),
                                  //     style: const TextStyle(
                                  //       color: Color(0xff3C4048),
                                  //       fontSize: 12,
                                  //       decoration: TextDecoration.lineThrough,
                                  //     ),
                                  //   ),
                                ],
                              ),
                            ),
                    ),
                    appBar: AppBar(
                      title: Text('جزئیات محصول'),
                      leading: IconButton(
                          onPressed: () {
                            _onWillPop();
                          },
                          icon: Icon(Icons.arrow_back)),
                    ),
                    body: SafeArea(
                        child: SingleChildScrollView(
                            child: Container(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  splashColor: Colors.white,
                                  highlightColor: Colors.white,
                                  onPressed: () {
                                    if (!favoritmanager
                                        .isFavorite(widget.product)) {
                                      favoritmanager
                                          .addFavorite(widget.product);
                                    } else {
                                      favoritmanager.delete(widget.product);
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    favoritmanager.isFavorite(widget.product)
                                        ? CupertinoIcons.heart_fill
                                        : CupertinoIcons.heart,
                                    color: favoritmanager
                                            .isFavorite(widget.product)
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
                                            widget.data
                                                .toString()
                                                .toPersianDigit(),
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
                                                  Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
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
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.3,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(110),
                              ),
                            ),
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PageView.builder(
                                        controller: _controller,
                                        itemCount: f.length,
                                        itemBuilder: (context, index) {
                                          final data = f[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: index == 0
                                                ? Container(
                                                    width: size.width,
                                                    child: ImageLoadingService(
                                                      imageUrl: widget
                                                          .product.imageUrl,
                                                    ),
                                                  )
                                                : Container(
                                                    child: ImageLoadingService(
                                                      imageUrl: data.imageUrl,
                                                    ),
                                                  ),
                                          );
                                        }),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  left: 0,
                                  bottom: 8,
                                  child: Center(
                                    child: SmoothPageIndicator(
                                      controller: _controller,
                                      count: f.length,
                                      axisDirection: Axis.horizontal,
                                      effect: const SlideEffect(
                                          spacing: 8.0,
                                          radius: 4.0,
                                          dotWidth: 20.0,
                                          dotHeight: 2.0,
                                          paintStyle: PaintingStyle.stroke,
                                          strokeWidth: 1.5,
                                          dotColor: Colors.grey,
                                          activeDotColor: Colors.indigo),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            height: size.height * 0.2,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  widget.product.title,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                              ],
                            ),
                          ),
                          Container(
                            width: size.width,
                            // height: size.height * 0.8,
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                                bottom: Radius.circular(5),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('شعبه'),
                                // const SizedBox(
                                //   height: 15,
                                // ),
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
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                const Text('پروموشن ها'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'در صورت خرید 4 عدد به بالا 3% تخفیف دریافت می کنید'
                                        .toPersianDigit(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'در صورت خرید 4 عدد به بالا 100  امتیاز دریافت می کنید'
                                        .toPersianDigit(),
                                    style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 11,
                                    ),
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
                                    itemCount: f.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final data = f[index];

                                      return InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: ((context) => Detail(
                                                  product: data, data: 1)),
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 5, 5, 8),
                                              child: Column(
                                                children: [
                                                  ImageLoadingService(
                                                    imageUrl: data.imageUrl,
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
                                // const SizedBox(
                                //   height: 15,
                                // ),
                              ],
                            ),
                          ),
                          PropertyProduct(size: size),
                          UserOpinion(
                            size: size,
                            comment: comment,
                          ),
                          MyView(size: size), //دیدگاه کاربران
                        ],
                      ),
                    ))));
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
      // height: size.height * 0.25,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'ویژگی های محصول',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
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
            height: 10,
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
            height: 10,
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
      // height: size.height * 0.25,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
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
                      width: size.width * 0.47,
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
                                  dataComment.title,
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
                                  dataComment.description,
                                  textAlign: TextAlign.justify,
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    height: 2.1,
                                    fontSize: 10,
                                    color: Colors.black,
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
        // height: size.height * 0.25,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
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
