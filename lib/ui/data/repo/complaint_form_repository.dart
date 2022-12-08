import 'package:local_notification_flutter_project/ui/data/ClassInfo/complaint_form_info.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/complaint_form_data_source.dart';

final compaintFormRepository =
    CompaintFormRepository(ComplaintRemoteDataSource(httpClient));

abstract class ICompaintFormRepository {
  Future<List<ComplaintFormInfo>> complaint(String title, String fullname,
      String email, int phone, int codeorder, String description, String image);
}

class CompaintFormRepository implements ICompaintFormRepository {
  final IComplaintDataSource dataSource;

  CompaintFormRepository(this.dataSource);
  @override
  Future<List<ComplaintFormInfo>> complaint(
          String title,
          String fullname,
          String email,
          int phone,
          int codeorder,
          String description,
          String image) =>
      dataSource.complaint(
        title,
        fullname,
        email,
        phone,
        codeorder,
        description,
        image,
      );
}
