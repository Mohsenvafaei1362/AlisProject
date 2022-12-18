import 'dart:async';
import 'dart:convert';

import 'package:local_notification_flutter_project/ui/screens/Notification/services/notification_service.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/bannerRepository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/slider_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/user_info_repository.dart';
import 'package:local_notification_flutter_project/ui/models/Pepole/pepole.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/category_list.dart';
import 'package:local_notification_flutter_project/ui/screens/CommentSuggest/commentsuggest.dart';
import 'package:local_notification_flutter_project/ui/screens/Drawer/drawer.dart';
import 'package:local_notification_flutter_project/ui/screens/Festival/Festival.dart';
import 'package:local_notification_flutter_project/ui/screens/Ghole/ghole.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/bloc/home_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Product_List/product_list.dart';
import 'package:local_notification_flutter_project/ui/screens/Search/search.dart';
import 'package:local_notification_flutter_project/ui/screens/SliderDetailes/SliderDetails.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/productItem.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen_Ui extends StatefulWidget {
  HomeScreen_Ui({
    key,
    this.itemWidth = 176,
    this.itemHeight = 185,
  });

  final double itemWidth;
  final double itemHeight;

  @override
  State<HomeScreen_Ui> createState() => _HomeScreen_UiState();
}

class _HomeScreen_UiState extends State<HomeScreen_Ui> {
  // final PageController _controller = PageController();
  // GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final UiCartController cartController = Get.put(UiCartController());
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiDl _dl = Get.put(UiDl());
  HomeBloc? bloc;
  StreamSubscription<HomeState>? streamSubscription;
  // int _page = 1;
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
    bloc?.close();
    streamSubscription?.cancel();
  }

  NotificationService notificationService = NotificationService();

  final int maxTitleLength = 60;
  TextEditingController _textEditingController =
      TextEditingController(text: "هلدینگ عالیس");

  int segmentedControlGroupValue = 0;

  DateTime currentDate = DateTime.now();
  DateTime? eventDate;

  TimeOfDay currentTime = TimeOfDay.now();
  TimeOfDay? eventTime;

  Future<void> onCreate() async {
    await notificationService.showNotification(
      id: 2,
      title: _textEditingController.text,
      body: "یک پیغام جدید.",
      payload: jsonEncode({
        "title": _textEditingController.text,
        "body": "یک رویداد جدید ایجاد شده است.",
      }),
    );

    resetForm();
  }

  Future<void> cancelAllNotifications() async {
    await notificationService.cancelAllNotifications();
  }

  void resetForm() {
    segmentedControlGroupValue = 0;
    eventDate = null;
    eventTime = null;
  }

  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final PageController _controller = PageController();
    const rankPepole = Pepole.pepoles;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.position.maxScrollExtent;
    });

    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
          bannerRepository: bannerRepository,
          productRepository: productRepository,
          userInfoRepository: userInfoRepository,
          messageCountRepository: messageCountRepository,
          clubRepository: clubRepository,
          gholeRepository: gholeRepository,
          sliderRepository: sliderRepository,
        );
        bloc = homeBloc;
        streamSubscription = homeBloc.stream.listen((state) {
          if (_refreshController.isRefresh) {
            if (state is HomeSuccess) {
              _refreshController.refreshCompleted();
            } else if (state is HomeError) {
              _refreshController.refreshFailed();
            }
          }
        });
        homeBloc.add(
          const HomeStarted(isRefreshing: false),
        );

        return homeBloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            // Uint8List avatar = base64.decode(state.messageCount.first.Avatar);
            Uint8List _avatarImage = base64.decode(_dl.Avatar.value);
            Uint8List _avatarLevel = base64.decode(state.ghole.first.Avatar);
            List<Uint8List> _avatarLevellst = [];
            List<String> _avatarLevellink = [];
            for (var element in state.slider) {
              _avatarLevellst.add(
                base64.decode(
                  element.img.toString(),
                ),
              );
            }
            for (var element in state.slider) {
              _avatarLevellink.add(
                element.link.toString(),
              );
            }

            return Scaffold(
              backgroundColor: const Color.fromARGB(254, 250, 250, 250),
              drawer: DrawerScreen(
                club: state.club,
                ghole: state.ghole,
                messageCount: state.messageCount,
              ),
              appBar: AppBar(
                iconTheme:
                    const IconThemeData(color: Color.fromRGBO(0, 0, 0, 1)),
                // backgroundColor: Colors.green[300],
                backgroundColor: Colors.white70,
                elevation: 5,
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      scrollable: true,
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: const [
                                              Text(
                                                'تغییر کاربری',
                                                style: TextStyle(
                                                    color: Colors.indigoAccent),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.black26,
                                          ),
                                        ],
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Radio(
                                                      value: 'change',
                                                      groupValue: 1,
                                                      onChanged: (value) {}),
                                                  const Spacer(),
                                                  const Text('مشتری'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    'assets/icons/user.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Radio(
                                                      value: 'change',
                                                      groupValue: 1,
                                                      onChanged: (value) {}),
                                                  const Spacer(),
                                                  const Text('فروشنده'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    'assets/icons/user.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Radio(
                                                      value: 'change',
                                                      groupValue: 1,
                                                      onChanged: (value) {}),
                                                  const Spacer(),
                                                  const Text('موزع'),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Image.asset(
                                                    'assets/icons/user.png',
                                                    width: 24,
                                                    height: 24,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipOval(
                                child: _avatarImage.isEmpty
                                    ? const Icon(CupertinoIcons.person)
                                    : Image.memory(
                                        _avatarImage,
                                        width: 35,
                                        height: 35.5,
                                      ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Ghole(),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  // height: size.height * 0.7,
                                  // margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                                  // padding: EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border:
                                        Border.all(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipOval(
                                        child: _avatarImage.isEmpty
                                            ? const Icon(CupertinoIcons.person)
                                            : Image.memory(
                                                _avatarLevel,
                                                width: 20,
                                                height: 20,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(
                        //   width: 10,
                        // ),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
                          child: Container(
                            width: 130,
                            height: 45,
                            // color: Colors.amber,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  _dl.FName.value + ' ' + _dl.LName.value,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 10,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _dl.Role.value,
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      'امتیاز : ${state.club.first.Value}'
                                          .toPersianDigit(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                actions: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: -2,
                            right: 3,
                            child: Badge(
                              badgeContent: Text(
                                state.messageCount.length
                                    .toString()
                                    .toPersianDigit(),
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {
                              onCreate();

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //       builder: (context) => Directionality(
                              //           textDirection: TextDirection.rtl,
                              //           child: HomePage())),
                              // );
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => MessageBox(
                              //       message: state.messageCount,
                              //     ),
                              //   ),
                              // );
                            },
                            icon: const Icon(
                              CupertinoIcons.bell_fill,
                              color: Colors.black38,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              body: SafeArea(
                child:
                    // if (state is HomeSuccess) {
                    SmartRefresher(
                  controller: _refreshController,
                  header: const ClassicHeader(
                    completeText: 'با موفقیت انجام شد',
                    refreshingText: 'در حال به روز رسانی',
                    idleText: 'برای به روز رسانی پایین بکشید',
                    releaseText: 'رها کنید',
                    failedText: 'خطای نا مشخص',
                    refreshingIcon: Icon(CupertinoIcons.refresh_bold),
                    spacing: 2,
                    completeIcon: Icon(
                      CupertinoIcons.check_mark_circled,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ),
                  onRefresh: () {
                    BlocProvider.of<HomeBloc>(context).add(
                      const HomeStarted(isRefreshing: true),
                    );
                  },
                  child: ListView.builder(
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      switch (index) {
                        case 0:
                          return Search(
                            press: () {
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute<bool>(
                                  // settings: RouteSettings(name: ),
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      const Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ProductListScreen(
                                      sort: UiProductSort.latest,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        case 1:
                          return Slider(
                              state, _avatarLevellst, _avatarLevellink);
                        // return Banners(controller: _controller);
                        case 2:
                          return CategoryList();
                        case 3:
                          return NewProduct(
                            size: size,
                            state: state,
                            title: 'جدیدترین',
                            show: 'مشاهده همه  >',
                            titr: 'پیشنهاد\nشگفت\nانگیز',
                            backgroundColor: Colors.red,
                            image: 'assets/images/discount.png',
                            textColor: Colors.white,
                            itemCount: state.products.length + 1,
                            reverse: true,
                            indexcount: 0,
                            // discount: state.products[index].discount != 0,
                            press: () {
                              Navigator.of(context, rootNavigator: true).push(
                                CupertinoPageRoute<bool>(
                                  // settings: RouteSettings(name: ),
                                  fullscreenDialog: true,
                                  builder: (BuildContext context) =>
                                      const Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: ProductListScreen(
                                      sort: UiProductSort.latest,
                                    ),
                                  ),
                                ),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => const ProductListScreen(
                              //         sort: UiProductSort.latest),
                              //   ),
                              // );
                            },
                          );
                        case 4:
                          return const SizedBox(
                            height: 5,
                          );
                        case 5:
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Advertise(
                                size,
                                'https://static.cdn.asset.aparat.com/avt/14831296-7391-b__8068.jpg',
                                size.height * 0.2,
                              ),
                            ),
                          );
                        case 6:
                          return Advertise_1(size: size);
                        case 7:
                          return NewProduct(
                            size: size,
                            state: state,
                            title: 'محصولات',
                            show: 'مشاهده',
                            titr: 'پیشنهاد\nشگفت\nانگیز',
                            backgroundColor: Colors.white,
                            image: 'assets/images/discount.png',
                            textColor: Colors.white,
                            itemCount: state.products.length,
                            reverse: false,
                            indexcount: state.products.length + 1,
                            press: () {},
                          );
                        case 8:
                          return FestivalProducts(size, context);
                        case 9:
                          return TopPepole(size, rankPepole, size.width, 120);
                        case 10:
                          return Race();
                        case 11:
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Advertise(
                                size,
                                'https://www.boursenews.ir/files/fa/news/1399/3/17/195744_674.jpg',
                                size.height * 0.3,
                              ),
                            ),
                          );
                        case 12:
                          return Survey();
                        case 13:
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SurveryText(size, context),
                          );

                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ),
            );
          } else if (state is HomeLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is HomeError) {
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
                BlocProvider.of<HomeBloc>(context).add(
                  const HomeStarted(isRefreshing: true),
                );
              },
              child: Center(
                child: Text(state.exception.message),
              ),
            );
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }

  Container SurveryText(Size size, BuildContext context) {
    return Container(
      width: size.width,
      // height: size.height * 0.13,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Get.to(
              //     CommentSuggest());
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: CommentSuggest(),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.54,
                  child: const Text(
                    'چرا خرید از شرکت/سایت ما را انتخاب کردید؟',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  margin: const EdgeInsets.all(2),
                  child: Text(
                    'بازدید : 5 نفر'.toPersianDigit(),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.12,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      '10  امتیاز'.toPersianDigit(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.54,
                  child: const Text(
                    'چگونه وب‌سایت ما را پیدا کردید؟',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  margin: const EdgeInsets.all(2),
                  child: Text(
                    'بازدید : 5 نفر'.toPersianDigit(),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.12,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      '15  امتیاز'.toPersianDigit(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.54,
                  child: const Text(
                    ' آیا محصول موردنظر خود را راحت پیدا کردید؟',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 20,
                // ),
                Container(
                  margin: const EdgeInsets.all(2),
                  child: Text(
                    'بازدید : 5 نفر'.toPersianDigit(),
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(2),
                  width: size.width * 0.12,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: Text(
                      '5  امتیاز'.toPersianDigit(),
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row Survey() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'شرکت در نظر سنجی',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.red,
          ),
          onPressed: () {},
          child: const Text(
            'شرکت در نظر سنجی',
            style: TextStyle(
              fontFamily: 'IransansDn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Row Race() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'مسابقه شماره یک',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.white, onPrimary: Colors.red),
          onPressed: () {},
          child: const Text(
            'شرکت در مسابقات',
            style: TextStyle(
              fontFamily: 'IransansDn',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Column TopPepole(
    Size size,
    List<Pepole> rankPepole,
    double itemWidth,
    double itemHeight,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 10, 10),
          child: Row(
            children: const [
              Text(
                'سه نفر برتر مسابقات',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Container(
          width: itemWidth,
          height: itemHeight,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
              top: BorderSide(
                color: Colors.black12,
                width: 1,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              final data = rankPepole[index];
              return Container(
                width: size.width * 0.26,
                margin: const EdgeInsets.symmetric(horizontal: 13),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.2),
                  // border: Border.all(
                  //   color: Colors.blue,
                  //   width: 1,
                  // ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 33,
                        height: 33,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.asset(
                          data.image,
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        data.name,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data.score} امتیاز'.toPersianDigit(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${data.rank}'.toPersianDigit(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Text('امتیاز'),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column FestivalProducts(Size size, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
          child: Row(
            children: const [
              Text(
                'لیست جشنواره ها',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: size.width,
          margin: const EdgeInsets.all(15),
          // height: size.height * 0.13,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  // Get.to(
                  //     CommentSuggest());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Festival(),
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.54,
                      child: const Text(
                        'جشنواره تخفیف نوشابه های گازدار',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        'بازدید : 5 نفر'.toPersianDigit(),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.12,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'مشاهده'.toPersianDigit(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.54,
                      child: const Text(
                        'جشنواره تخفیف آبمیوه های گازدار',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        'بازدید : 5 نفر'.toPersianDigit(),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.12,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'مشاهده'.toPersianDigit(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.54,
                      child: const Text(
                        'جشنواره تخفیف دوغ عالیس',
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    Container(
                      margin: const EdgeInsets.all(2),
                      child: Text(
                        'بازدید : 5 نفر'.toPersianDigit(),
                        style: const TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(2),
                      width: size.width * 0.12,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: Text(
                          'مشاهده'.toPersianDigit(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  CachedNetworkImage Advertise(Size size, String image, double height) {
    return CachedNetworkImage(
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CupertinoActivityIndicator(),
        ],
      ),
      imageUrl: image,
      height: height,
      width: size.width,
      fit: BoxFit.cover,
    );
  }

  CarouselSlider Slider(
      HomeSuccess state, List<Uint8List> img, List<String> link) {
    List linkUrl = [];
    for (var element in link) {
      linkUrl.add(element);
    }
    return CarouselSlider.builder(
      // itemCount: state.banners.length,
      itemCount: img.length,
      itemBuilder: (context, index, realIndex) {
        return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => SliderDetails(
                          img: img[index],
                          link: linkUrl[index],
                        )),
              );
            },
            child: Image.memory(img[index]));
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        // autoPlay: true,
      ),
    );
  }

  Column NewProduct({
    required Size size,
    required int itemCount,
    required int indexcount,
    required bool reverse,
    required HomeSuccess state,
    required String title,
    required String show,
    required String titr,
    required String image,
    required Color backgroundColor,
    required Color textColor,
    required Function() press,
  }) {
    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.47,
          padding: EdgeInsets.symmetric(vertical: 8),
          color: backgroundColor,
          child: ListView.builder(
            // controller: controller,
            // reverse: reverse,
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              // int revercedIndex = state.products.length - 1 - index;
              if (index == indexcount) {
                final data = state.products[0];

                return Container(
                  width: size.width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              titr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: textColor,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Image.asset(
                              image,
                              width: 100,
                              height: 100,
                            ),
                            TextButton(
                              onPressed: press,
                              child: Text(
                                show,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // if (data.discount != 0)
                      ProductItem(
                        product: data,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ],
                  ),
                );
              } else if (index < state.products.length) {
                final data = state.products[index];
                return ProductItem(
                  product: data,
                  borderRadius: BorderRadius.circular(10),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}

class Advertise_1 extends StatelessWidget {
  const Advertise_1({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/30.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/40.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white70, width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: SizedBox(
              width: size.width * 0.3,
              height: size.height * 0.12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/0502 (1).JPG',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final UiBannerEntity banner;
  const _Slide({
    Key? key,
    required this.banner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: ImageLoadingService(
        imageUrl: banner.imageUrl_1,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
