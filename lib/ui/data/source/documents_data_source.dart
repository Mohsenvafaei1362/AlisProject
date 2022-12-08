import 'package:local_notification_flutter_project/ui/controller/controller.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/DocumentsDto.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

final UiDl _dl = Get.put(UiDl());

abstract class IDocumentsDataSource {
  Future<List<UiDocumentsInfo>> imageUrl(UiDocumentsInfo document);
}

// final String ModelTitle;
//   final String pic;
//   final int modelId;
//   final int userRef;
//   final int dlRef;
//   final String desc;
//   final String phoneNumber;
//   final String registerLevelRef;
//   final int tableRef;
//   final String tableTitle;
//   final int Creator;

class DocumentsRemoteDataSource implements IDocumentsDataSource {
  final Dio httpClient;
  DocumentsRemoteDataSource(this.httpClient);
  @override
  Future<List<UiDocumentsInfo>> imageUrl(UiDocumentsInfo document) async {
    final response = await httpClient.post(
      'Files',
      data: (<String, String>{
        "ModelTitle": document.ModelTitle,
        "Pic": document.pic,
        "ModelId": document.modelId.toString(),
        "UserRef": document.userRef.toString(),
        "DlRef": document.dlRef.toString(),
        "Desc": document.desc,
        "PhoneNumber": document.phoneNumber,
        "RegisterLevelRef": document.registerLevelRef,
        "TableTitle": document.tableTitle,
        "TableRef": document.tableRef.toString(),
        "Creator": document.Creator.toString(),
      }),
    );
    final List<UiDocumentsInfo> documents = [];
    if (response.data is List<dynamic>) {
      if ((response.data as List<dynamic>).length == 1) {
        // var element =
        //     UiDocumentsInfo.fromJson((response.data as List<dynamic>).first);
        switch ('RegisterLvelTitle') {
        }
      } else {
        print('object');
      }
    }
    return documents;
  }
}
