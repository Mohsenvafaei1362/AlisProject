import 'package:local_notification_flutter_project/ui/data/repo/category_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/CategorySelected/CategorySelected.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/bloc/category_bloc.dart';
import 'package:local_notification_flutter_project/ui/screens/Product_List/product_list.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class CategoryList extends StatefulWidget {
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<CategoryBloc>(
      create: (context) {
        final bloc = CategoryBloc(categoryRepository: categoryRepository);
        bloc.add(const CategoryStarted(isRefreshing: false));
        return bloc;
      },
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategorySuccess) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 70,
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 230, 19, 19),
                color: Color(0xffffffff),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.categoryImage.length,
                itemBuilder: (context, index) {
                  final category = state.categoryImage[index];
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        // case 0:
                        //   Get.to(() => const CategorySelected(
                        //         name: 'آب معدنی',
                        //       ));
                        //   break;
                        case 0:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 1,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 1:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 2,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 2:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 3,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 3:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 4,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 4:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 5,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 5:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 6,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 6:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 7,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 7:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 8,
                                ),
                              ),
                            ),
                          );
                          break;
                        case 8:
                          Navigator.of(context, rootNavigator: true).push(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: ProductListScreen(
                                  categoryId: 9,
                                ),
                              ),
                            ),
                          );
                          break;
                        default:
                      }
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: size.height,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.fromLTRB(1, 0, 1, 0),
                      padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageLoadingService(
                            imageUrl: category.image,
                            width: 30,
                            height: 30,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            category.title,
                            style: TextStyle(
                              color: index == selectedIndex
                                  ? const Color(0xffe65100)
                                  : const Color.fromARGB(204, 46, 46, 46),
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
            return Center(
              child: Text(state.exception.message),
            );
          } else {
            throw Exception('state is not supported');
          }
        },
      ),
    );
  }
}
