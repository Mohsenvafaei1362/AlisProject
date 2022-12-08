import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:dio/dio.dart';

validateResponse(Response response) {
  if (response.statusCode != 200) {
    throw AppException();
  }
}
