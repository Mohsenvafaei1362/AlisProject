import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/productItem.dart';
import 'package:local_notification_flutter_project/ui/screens/Product_List/bloc/product_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductListScreen extends StatefulWidget {
  final int categoryId;
  final int modelId;
  final String model;
  ProductListScreen({
    key,
    required this.categoryId,
    required this.modelId,
    required this.model,
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

enum ViewType {
  grid,
  list,
}

class _ProductListScreenState extends State<ProductListScreen> {
  ProductListBloc? productListBloc;
  ViewType viewType = ViewType.grid;
  final TextEditingController searchController = TextEditingController();
  ProductEntity? data;
  List<ProductEntity>? dataSort;
  Iterable<ProductEntity>? data2;
  int data1 = 0;
  int? _sort;
  int? count;
  int? indexsort;

  @override
  void dispose() {
    super.dispose();
    productListBloc?.close();
  }

  sort(List<ProductEntity> product) {
    switch (_sort) {
      case 2:
        product.sort(
          (a, b) {
            return a.price.compareTo(b.price);
          },
        );
        break;
      case 3:
        product.sort(
          (a, b) {
            return b.price.compareTo(a.price);
          },
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('لیست محصولات'),
      ),
      body: SafeArea(
        child: BlocProvider<ProductListBloc>(
          create: (context) {
            final bloc = ProductListBloc(productRepository)
              ..add(ProductListStarted(
                categoryId: widget.categoryId,
                modelId: widget.modelId,
                modelName: widget.model,
              ));
            productListBloc = bloc;
            return bloc;
          },
          child: BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListSuccess) {
                final products = state.products;

                return Column(
                  children: [
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(32),
                                            ),
                                          ),
                                          builder: (context) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: SizedBox(
                                                height: 400,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 24, bottom: 24),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        'انتخاب مرتب سازی',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount: state
                                                              .sortNames.length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final selecktedSortIndex =
                                                                state
                                                                    .categoryId;

                                                            return InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  _sort = index;
                                                                  indexsort =
                                                                      index;
                                                                });
                                                                productListBloc!
                                                                    .add(
                                                                  ProductListStarted(
                                                                      categoryId:
                                                                          index,
                                                                      modelId:
                                                                          widget
                                                                              .modelId,
                                                                      modelName:
                                                                          widget
                                                                              .model),
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        16,
                                                                        8,
                                                                        16,
                                                                        8),
                                                                child: SizedBox(
                                                                  height: 32,
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        state.sortNames[
                                                                            index],
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      if (index ==
                                                                          selecktedSortIndex)
                                                                        Icon(
                                                                          CupertinoIcons
                                                                              .check_mark_circled_solid,
                                                                          color: Theme.of(context)
                                                                              .colorScheme
                                                                              .primary,
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    icon: const Icon(CupertinoIcons.sort_down),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text('مرتب سازی'),
                                      // Text(
                                      //   UiProductSort.names[indexsort!],
                                      //   style:
                                      //       Theme.of(context).textTheme.caption,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  viewType = viewType == ViewType.grid
                                      ? ViewType.list
                                      : ViewType.grid;
                                });
                              },
                              icon: const Icon(CupertinoIcons.square_grid_2x2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Column(
                          children: [
                            TextField(
                              controller: searchController,
                              onChanged: (value) => setState(() {}),
                              decoration: const InputDecoration(
                                  labelText: 'جستجو',
                                  suffixIcon: Icon(Icons.search)),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  /// width / height = 0.65
                                  childAspectRatio:
                                      viewType == ViewType.grid ? 0.65 : 1.2,
                                  // crossAxisCount: 4,
                                  crossAxisCount:
                                      viewType == ViewType.grid ? 2 : 1,
                                ),
                                itemCount: count,
                                itemBuilder: (context, index) {
                                  if (searchController.text.isEmpty) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      setState(() {
                                        count = products.length;
                                        sort(products);
                                      });
                                    });
                                    final data = products[index];
                                    return ProductItem(
                                      product: data,
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    );
                                  } else {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((timeStamp) {
                                      setState(() {
                                        count = products
                                            .where((e) => e.title.contains(
                                                searchController.text))
                                            .length;
                                        sort(products);
                                      });
                                    });
                                    final d = products
                                        .where((e) => e.title
                                            .contains(searchController.text))
                                        .map((e) => e)
                                        .toList();
                                    final data = d[index];

                                    return ProductItem(
                                      product: data,
                                      borderRadius: BorderRadius.circular(
                                        12,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is ProductListLoading) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (state is ProductListError) {
                return Center(child: Text(state.exception.message));
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
