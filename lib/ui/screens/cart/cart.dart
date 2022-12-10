import 'dart:async';

import 'package:local_notification_flutter_project/ui/data/ClassInfo/cart_response.dart';
import 'package:local_notification_flutter_project/ui/data/repo/auth_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/auth/auth.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/bloc/cart_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart_item.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/price_info.dart';
import 'package:local_notification_flutter_project/ui/screens/shipping/sipping.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/empty_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;

  final RefreshController _refreshController = RefreshController();

  StreamSubscription? streamSubscription;
  bool stateSuccess = false;
  CartResponseFake? _data;
  List<CartResponseFake>? _data_1;
  num? payablePrice;
  num? shipping;
  double _totalPrice = 0.0;
  double _payablePrice = 0.0;
  double _shippingCost = 0.0;
  @override
  void initState() {
    super.initState();
    AuthRepository.authChangeNotifire.addListener(authChangeNotifireListener);
  }

  void authChangeNotifireListener() {
    cartBloc?.add(
      CartAuthInfoChanged(AuthRepository.authChangeNotifire.value),
    );
  }

  @override
  void dispose() {
    AuthRepository.authChangeNotifire
        .removeListener(authChangeNotifireListener);
    cartBloc?.close();
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('سبد خرید'),
      ),
      floatingActionButton: Visibility(
        visible: stateSuccess,
        child: Container(
          width: size.width,
          margin: const EdgeInsets.only(right: 48, left: 48),
          child: FloatingActionButton.extended(
            onPressed: () {
              final state = cartBloc?.state;
              if (state is CartSuccess) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: ShippingScreen(
                        payablePrice: _payablePrice + _shippingCost,
                        totalPrice: _payablePrice,
                        shippingCost: _shippingCost,
                      ),
                    ),
                  ),
                );
              }
            },
            label: const Text('پرداخت'),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocProvider(
        create: (context) {
          final bloc = CartBloc(cartRepository);
          streamSubscription = bloc.stream.listen((state) {
            setState(() {
              stateSuccess = state is CartSuccess;
            });

            if (_refreshController.isRefresh) {
              if (state is CartSuccess) {
                _refreshController.refreshCompleted();
              } else if (state is CartError) {
                _refreshController.refreshFailed();
              }
            }
          });
          cartBloc = bloc;
          bloc.add(CartStarted(AuthRepository.authChangeNotifire.value));
          return bloc;
        },
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                ),
              );
            } else if (state is CartError) {
              return SmartRefresher(
                controller: _refreshController,
                header: const ClassicHeader(
                  completeText: 'با موفقیت انجام شد',
                  refreshingText: 'در حال به روز رسانی',
                  idleText: 'برای به روز رسانی پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'خطای نا مشخص',
                  spacing: 2,
                  completeIcon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                onRefresh: () {
                  cartBloc?.add(
                    CartStarted(AuthRepository.authChangeNotifire.value,
                        isRefreshing: true),
                  );
                },
                child: Center(
                  child: Text(state.exception.message),
                ),
              );
            } else if (state is CartSuccess) {
              calculatePriceInfo(state.cartResponse);
              return SmartRefresher(
                controller: _refreshController,
                header: const ClassicHeader(
                  completeText: 'با موفقیت انجام شد',
                  refreshingText: 'در حال به روز رسانی',
                  idleText: 'برای به روز رسانی پایین بکشید',
                  releaseText: 'رها کنید',
                  failedText: 'خطای نا مشخص',
                  spacing: 2,
                  completeIcon: Icon(
                    CupertinoIcons.check_mark_circled,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                onRefresh: () {
                  cartBloc?.add(
                    CartStarted(AuthRepository.authChangeNotifire.value,
                        isRefreshing: true),
                  );
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemBuilder: (context, index) {
                    if (index < state.cartResponse.length) {
                      final data = state.cartResponse[index];
                      // calculatePriceInfo(state.cartResponse);
                      _data = state.cartResponse[index];
                      return CartItem(
                        data: data,
                        onDeleteButtonClicked: () {
                          cartBloc?.add(
                            CartDeleteButtonClicked(data.product_id),
                          );
                        },
                        onDecreaseButton: () {
                          if (data.product_code > 1) {
                            cartBloc?.add(
                              DecreaseCountButtonClicked(data.product_id),
                            );
                          }
                        },
                        onIncreaseButton: () {
                          cartBloc?.add(
                            IncreaseCountButtonClicked(data.product_id),
                          );
                        },
                      );
                    } else {
                      // payablePrice = _data!.product_price * _data!.product_code;
                      // shipping = _data!.product_price <= 2500000 ? 300000 : 0;
                      return PriceInfo(
                        payablePrice: _payablePrice + _shippingCost,
                        totalPrice: _payablePrice,
                        shippingCost: _shippingCost,
                        // payablePrice: state.cartResponse.payablePrice,
                        // totalPrice: state.cartResponse.totalPrice,
                        // shippingCost: state.cartResponse.shippingConst,
                      );
                    }
                  },
                  itemCount: state.cartResponse.length + 1,
                ),
              );
            } else if (state is CartAuthRequired) {
              return EmptyView(
                message: 'برای مشاهده سبد خرید ابتدا وارد حساب کاربری خود شوید',
                callToAction: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).push(
                      CupertinoPageRoute<bool>(
                        fullscreenDialog: true,
                        builder: (BuildContext context) => const Directionality(
                          textDirection: TextDirection.rtl,
                          child: AuthScreen(),
                        ),
                      ),
                    );
                  },
                  child: const Text('ورود به حساب کاربری'),
                ),
                image: Image.asset('assets/images/1234.jpg'),
              );
            } else if (state is CartEmpty) {
              return EmptyView(
                message: 'تا کنون هیچ محصولی به سبد خرید خود اضافه نکرده اید',
                image: Image.asset('assets/images/76.png'),
              );
            } else {
              throw Exception('current cart state is not valid');
            }
          },
        ),
      ),
    );
  }

  calculatePriceInfo(List<CartResponseFake> cartResponse) {
    _totalPrice = 0;
    _payablePrice = 0;
    _shippingCost = 0;

    cartResponse.forEach((cartItem) {
      _totalPrice += cartItem.product_price * cartItem.product_code;
      _payablePrice += cartItem.product_price * cartItem.product_code;
    });
    _shippingCost = _payablePrice >= 3000000 ? 0 : 300000;
    return (cartResponse);
  }
}
