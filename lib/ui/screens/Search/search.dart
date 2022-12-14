// import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({key, required this.press});

  final GestureTapCallback press;

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.04,
      // padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
            )
          ]
          // border: Border.all(
          //   color: Colors.black12,
          //   width: 1,
          // ),
          ),
      child: InkWell(
        onTap: widget.press,
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Icon(
                CupertinoIcons.search,
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Directionality(
                //       textDirection: TextDirection.rtl,
                //       child: Filter(),
                //     ),
                //   ),
                // );
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                width: size.width * 0.05,
                height: size.height * 0.05,
                child: const Icon(CupertinoIcons.line_horizontal_3_decrease),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
