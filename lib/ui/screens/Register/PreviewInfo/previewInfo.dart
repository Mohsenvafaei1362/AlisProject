import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/data/repo/previewInfo_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Register/PreviewInfo/bloc/preview_info_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class PreviewInfo extends StatefulWidget {
  const PreviewInfo({Key? key}) : super(key: key);

  @override
  State<PreviewInfo> createState() => _PreviewInfoState();
}

class _PreviewInfoState extends State<PreviewInfo> {
  final UiPreviewData previewData = Get.put(UiPreviewData());
  final UiPhoneController phoneController = Get.put(UiPhoneController());
  final UiShowInfo showInfo = Get.put(UiShowInfo());
  final UiDl _dl = Get.put(UiDl());

  PreviewInfoBloc? previewInfoBloc;

 

  @override
  void dispose() {
    super.dispose();
    previewInfoBloc?.close();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    setState(() {});
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SizedBox(
          width: size.width * 0.9,
          height: size.height * 0.06,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              previewInfoBloc?.state is PreviewInfoLoading
                  ? null
                  : previewInfoBloc?.add(PreviewInfoClickedButton());
              // putregistermemberlevel(6, '6', 'Congratulation');
              // Get.off(
              //   const Congratulation(),
              // );
            },
            label: previewInfoBloc?.state is PreviewInfoLoading
                ? const CupertinoActivityIndicator()
                : const Text(
                    'تایید و ادامه',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
          ),
        ),
        body: BlocProvider<PreviewInfoBloc>(
          create: (context) {
            final bloc = PreviewInfoBloc(previewInfoRepository);
            previewInfoBloc = bloc;
            bloc.add(PreviewInfoStarted());
            return bloc;
          },
          child: SafeArea(
            child: SingleChildScrollView(
              child: BlocBuilder<PreviewInfoBloc, PreviewInfoState>(
                builder: (context, state) {
                  return WillPopScope(
                    onWillPop: () {
                      //we need to return a future
                      return Future.value(false);
                    },
                    child: SizedBox(
                      width: size.width,
                      height: size.height * 0.9,
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.25,
                            child: Image.asset(
                              'assets/images/64.png',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'نام و نام خانوادگی',
                            text: "${_dl.FName.value} ${_dl.LName.value}",
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'کد ملی ',
                            text: _dl.NastinalCode.value.toPersianDigit(),
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'ایمیل',
                            text: _dl.Email.value.toPersianDigit(),
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'استان',
                            text: _dl.Ostan.value,
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'شهر',
                            text: _dl.City.value,
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: ' کد پستی ',
                            text: _dl.PostalCode.value
                                .toString()
                                .toPersianDigit(),
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: ' تلفن  ',
                            text: phoneController.phone.value.toPersianDigit(),
                          ),
                          BuildCard(
                            size: size,
                            dl: _dl,
                            title: 'نقش',
                            text: _dl.Role.value.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    Key? key,
    required this.size,
    required UiDl dl,
    required this.title,
    required this.text,
  })  : _dl = dl,
        super(key: key);

  final Size size;
  final UiDl _dl;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * 0.07,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 10),
              alignment: Alignment.centerRight,
              color: Colors.grey[100],
              width: size.width * 0.35,
              height: size.height,
              child: Text(title),
            ),
            Container(
              alignment: Alignment.center,
              // color: Colors.amber,
              width: size.width * 0.45,
              height: size.height,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
