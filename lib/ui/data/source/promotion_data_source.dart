import 'package:dio/dio.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/promotion.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/ValidationResponse.dart';

abstract class IPromotionDataSource {
  Future<List<PromotionInfo>> promotionList({
    required int poductId,
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  });
}

class PromotionRemoteDataSource implements IPromotionDataSource {
  final Dio httpClient;

  PromotionRemoteDataSource(this.httpClient);
  @override
  Future<List<PromotionInfo>> promotionList({
    required int poductId,
    required int categoryId,
    required int modelId,
    required int userId,
    required int sellCenter,
    required String model,
    required int visitorRef,
    required int roleRef,
    required int usersGroupRef,
  }) async {
    final response = await httpClient.get('PromotionDetaile');
    validateResponse(response);
    final List<PromotionInfo> promotionList = [];
    (response.data as List).forEach((element) {
      promotionList.add(PromotionInfo.fromJson(element));
    });
    return promotionList;
  }
}
