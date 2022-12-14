import 'package:flutter/material.dart';

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
          child: Container(
            width: size.width,
            height: size.height,
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
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
          ),
        ),
      ),
    );
  }
}
