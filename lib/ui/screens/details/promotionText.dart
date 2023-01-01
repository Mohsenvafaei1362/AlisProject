import 'package:flutter/material.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';

class PromotionText extends StatelessWidget {
  const PromotionText({key, required this.promotion});
  final List<PromotionEntity> promotion;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('پروموشن ها'),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(color: Colors.white),
          child: ListView.builder(
            itemCount: promotion.length,
            itemBuilder: (context, index) {
              final data = promotion[index];
              return Container(
                child: Text(
                  data.text,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 2.5,
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
