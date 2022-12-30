import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/products_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:local_notification_flutter_project/ui/screens/details/details.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CategorySelected extends StatefulWidget {
  const CategorySelected({
    Key? key,
    required this.name,
    this.itemWidth = 120,
    this.itemHeight = 150,
  }) : super(key: key);

  final String name;
  final double itemWidth;
  final double itemHeight;

  @override
  State<CategorySelected> createState() => _CategorySelectedState();
}

class _CategorySelectedState extends State<CategorySelected> {
  ProductsBloc? productBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.06,
          child: FloatingActionButton.extended(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              backgroundColor: Colors.red,
              onPressed: () {
                // print(productBloc?.state);
                Navigator.of(context).pop();
              },
              label:
                  // productBloc?.state is ProductFiltterLoading
                  //     ? const CupertinoActivityIndicator(
                  //         color: Colors.white,
                  //         radius: 15,
                  //       )
                  //     :
                  const Text(
                'بازگشت',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )),
        ),
        backgroundColor: const Color(0xffeceff1),
        body: BlocProvider<ProductsBloc>(
          create: (context) {
            final bloc = ProductsBloc(
              cartRepository: cartRepository,
              productRepository: productRepository,
            );
            productBloc = bloc;
            bloc.add(const ProductStarted('water'));
            return bloc;
          },
          child: SafeArea(
            child: SingleChildScrollView(
                child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductFiltterSuccess) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon:
                                  const Icon(Icons.keyboard_backspace_rounded)),
                          Container(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                            width: size.width * 0.87,
                            height: size.height * 0.06,
                            decoration: const BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black26,
                                ),
                              ),
                              // color: Colors.amber,
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'هلدینگ عالیس',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  ),
                                ),
                                const Spacer(),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Badge(
                                    badgeContent: Text(
                                      '2'.toPersianDigit(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: CartScreen(),
                                          // child:Login(onChanged: onChanged),
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Align(
                                    child: Icon(CupertinoIcons.cart),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(1, 10, 1, 0),
                        width: size.width,
                        height: size.height * 0.77,
                        // color: Colors.lightBlueAccent,
                        child: ListView.builder(
                          itemCount: state.filtterProduct.length,
                          itemBuilder: (contex, index) {
                            if (state.filtterProduct[index].productname
                                .contains(widget.name)) {
                              final data = state.filtterProduct[index];
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contex) => Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: DetailScreen(
                                            product: data,
                                            data: 1,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                    width: widget.itemWidth,
                                    height: widget.itemHeight,
                                    // color: Colors.amber[100],
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.productname,
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  // Icon(/
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                    size: 15,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${data.id}'
                                                        .toPersianDigit(),
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.price.withPriceLable
                                                        .toPersianDigit(),
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      // cartController.AddProduct(
                                                      //     userMap[index]);
                                                    },
                                                    child: const Icon(
                                                      CupertinoIcons
                                                          .cart_badge_plus,
                                                      color: Colors.green,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                                              ImageLoadingService(
                                                imageUrl: data.productimg,
                                                width: widget.itemWidth,
                                                height: widget.itemHeight,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                              // return EmptyView(
                              //   message: 'محصول یافت نشد',
                              //   image: Image.asset('assets/images/12.jpg'),
                              // );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is ProductFiltterLoading) {
                  return SizedBox(
                    width: size.width,
                    height: size.height * 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        Text('در حال دریافت اطلاعات')
                      ],
                    ),
                  );
                } else if (state is ProductFiltterError) {
                  return Center(
                    child: Text(state.exception.message),
                  );
                } else {
                  throw Exception('state is not supported');
                }
              },
            )),
          ),
        ),
      ),
    );
  }
}
