import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:local_notification_flutter_project/ui/controller/controller.dart';

final TestApi testApi = Get.put(TestApi());
final httpClient = Dio(
  BaseOptions(
    baseUrl: "http://192.168.1.173/AlisApi/api/v1/",
    // baseUrl: "http://185.135.229.96:805/AlisApi/api/v1/",
  ),
);
// ..interceptors.add(
//   InterceptorsWrapper(
//     onRequest: (Options, handler) {
//       final authInfo = AuthRepository.authChangeNotifire.value;
//       if (authInfo != null && authInfo.accessToken.isNotEmpty) {
//         Options.headers['Authorization'] = 'Bearer${authInfo.accessToken}';
//       }
//       handler.next(Options);
//     },
//   ),
// );
final httpClient2 = Dio(
  BaseOptions(
    baseUrl: "http://217.219.74.100/api/1.0/alis/",
  ),
)..interceptors.add(
    InterceptorsWrapper(
      onRequest: (Options, handler) {
        final authInfo = testApi.token.value;
        if (authInfo != null) {
          Options.headers['Authorization'] = 'Bearer${authInfo}';
        }
        handler.next(Options);
      },
    ),
  );
final httpProduct = Dio(
  BaseOptions(
    baseUrl: "http://192.168.1.173:3000/",
    // baseUrl: "http://185.135.229.96:806/",
  ),
);

final httpNike = Dio(
  BaseOptions(baseUrl: 'https://fakestoreapi.com/'),
);
