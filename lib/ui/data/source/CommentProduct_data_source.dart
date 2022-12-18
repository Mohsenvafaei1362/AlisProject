import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class ICommentProductDataSource {
  Future<void> commentProduct(
    String txt1,
    String txt2,
    String txt3,
    String txt4,
  );
}

class CommentProductDataSource implements ICommentProductDataSource {
  final Dio httpClient;

  CommentProductDataSource(this.httpClient);
  @override
  Future<void> commentProduct(
      String txt1, String txt2, String txt3, String txt4) async {
    final response = await httpClient.post(
      'path',
      data: {
        'txt1': txt1,
        'txt2': txt2,
        'txt3': txt3,
        'txt4': txt4,
      },
    );
    validateResponse(response);
  }
}
