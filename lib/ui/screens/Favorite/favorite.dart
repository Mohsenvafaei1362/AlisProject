import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/screens/details/details.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/empty_state.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/image_loading_service.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/pricelable.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  Color? color;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('لیست علاقه مندی ها'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ValueListenableBuilder<Box<ProductEntity>>(
            valueListenable: favoritmanager.listenable,
            builder: (context, box, child) {
              final products = box.values.toList();
              if (products.length > 0) {
                color = Colors.grey[200];
                return Container(
                  width: size.width,
                  height: size.height * 0.85,
                  padding: EdgeInsets.only(bottom: 30),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final data = products[index];
                      return Container(
                        width: size.width,
                        height: size.height * 0.15,
                        margin: EdgeInsets.fromLTRB(8, 2, 8, 2),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1,
                          ),
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  listViewDetailId: data.id,
                                  data: 1,
                                  pid: data.productId,
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            favoritmanager.delete(data);
                          },
                          child: Row(
                            children: [
                              ImageLoadingService(
                                imageUrl: data.imageUrl,
                                width: 100,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.title),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data.price.withPriceLableDouble
                                        .toString()
                                        .toPersianDigit(),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.pink,
                                  size: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }

              color = Colors.white;

              return Container(
                // color: Colors.amber,
                width: size.width,
                height: size.height,
                child: EmptyView(
                  message:
                      'تا کنون هیچ محصولی به لیست علاقه مندی ها اضافه نکرده اید',
                  image: Image.asset(
                    'assets/images/emptyfavorite.png',
                    fit: BoxFit.cover,
                    width: 200,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
