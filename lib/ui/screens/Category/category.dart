import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/category_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/CategorySelected/CategorySelected.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/bloc/category_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Category extends StatefulWidget {
  const Category({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<Category> createState() => _CategoryState();
}

final UiAddressIp getAddress2 = Get.put(UiAddressIp());

class _CategoryState extends State<Category> {
  final UiImageCategory imageCategory = Get.put(UiImageCategory());
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
  }

  // final List<Map> myProducts =
  //     List.generate(9, (index) => {"id": index, "name": "Product $index"})
  //         .toList();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     // statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('دسته بندی محصولات'),
      ),
      body: BlocProvider<CategoryBloc>(
        create: (context) {
          final bloc = CategoryBloc(categoryRepository: categoryRepository);
          bloc.add(const CategoryStarted(isRefreshing: false));
          return bloc;
        },
        child: SafeArea(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategorySuccess) {
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
                    BlocProvider.of<CategoryBloc>(context).add(
                      const CategoryStarted(isRefreshing: true),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.25,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          child: Image.asset(
                            'assets/images/99.08.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: state.categoryImage.length,
                              itemBuilder: (BuildContext ctx, index) {
                                final data = state.categoryImage[index];
                                return InkWell(
                                  borderRadius: BorderRadius.circular(15),
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const CategorySelected(
                                              name: 'آب معدنی',
                                            ));
                                        break;
                                      case 1:
                                        Get.to(() => const CategorySelected(
                                              name: 'دوغ',
                                            ));
                                        break;
                                      case 2:
                                        Get.to(() => const CategorySelected(
                                              name: 'آبمیوه گازدار',
                                            ));
                                        break;
                                      case 3:
                                        Get.to(() => const CategorySelected(
                                              name: 'آبمیوه گازدار تشریفاتی',
                                            ));
                                        break;
                                      case 4:
                                        Get.to(() => const CategorySelected(
                                              name: 'شیر',
                                              // name: 'شیر طعم دار',
                                            ));
                                        break;
                                      case 5:
                                        Get.to(() => const CategorySelected(
                                              name: 'نوشابه',
                                            ));
                                        break;
                                      case 6:
                                        Get.to(() => const CategorySelected(
                                              name: 'شیر ساده',
                                            ));
                                        break;
                                      case 7:
                                        Get.to(() => const CategorySelected(
                                              name: 'ماءالشعیر',
                                            ));
                                        break;
                                      case 8:
                                        Get.to(() => const CategorySelected(
                                              name: 'نکتار',
                                            ));
                                        break;
                                      default:
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        // color: Colors.amber,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          ImageLoadingService(
                                            imageUrl: data.image,
                                            width: 70,
                                            height: 70,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            data.title,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 9,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is CategoryLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    // radius: 30,
                    color: Colors.blue,
                  ),
                );
              } else if (state is CategoryError) {
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
                    BlocProvider.of<CategoryBloc>(context).add(
                      const CategoryStarted(isRefreshing: true),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.exception.message),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<CategoryBloc>(context).add(
                            const CategoryStarted(isRefreshing: true),
                          );
                        },
                        child: Text(
                          'تلاش دوباره',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                throw Exception('state is not supported');
              }
            },
          ),
        ),
      ),
    );
  }
}
