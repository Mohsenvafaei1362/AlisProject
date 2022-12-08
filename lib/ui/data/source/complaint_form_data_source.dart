import 'package:local_notification_flutter_project/ui/data/ClassInfo/complaint_form_info.dart';
import 'package:dio/dio.dart';

abstract class IComplaintDataSource {
  Future<List<ComplaintFormInfo>> complaint(String title, String fullname,
      String email, int phone, int codeorder, String description, String image);
}

class ComplaintRemoteDataSource implements IComplaintDataSource {
  final Dio httpClient;

  ComplaintRemoteDataSource(this.httpClient);
  @override
  Future<List<ComplaintFormInfo>> complaint(
    String title,
    String fullname,
    String email,
    int phone,
    int codeorder,
    String description,
    String image,
  ) async {
    final response = await httpClient.post('path', data: {
      'title': title,
      'fullname': fullname,
      'email': email,
      'codeorder': codeorder,
      'description': description,
      'image': image,
    });
    final List<ComplaintFormInfo> complaint = [];
    // validateResponse(response);
    for (var element in (response.data as List)) {
      complaint.add(ComplaintFormInfo.fromJson(element));
    }
    return complaint;
  }
}
