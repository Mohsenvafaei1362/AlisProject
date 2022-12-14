import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/favorit_manager.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';

class FavoriteList extends StatelessWidget {
  const FavoriteList({key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              return Container(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final data = products[index];
                    return Container(
                      width: size.width,
                      height: size.height,
                      child: Column(
                        children: [
                          Text('data'),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
