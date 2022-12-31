import 'package:local_notification_flutter_project/ui/data/ClassInfo/promotion.dart';
import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/promotion_data_source.dart';

final promotionRepository =
    PromotionRepository(PromotionRemoteDataSource(httpClient));

abstract class IPromotionRepository {
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

class PromotionRepository implements IPromotionRepository {
  final IPromotionDataSource dataSource;

  PromotionRepository(this.dataSource);
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
  }) =>
      dataSource.promotionList(
        categoryId: categoryId,
        model: model,
        userId: userId,
        sellCenter: sellCenter,
        modelId: modelId,
        poductId: poductId,
        roleRef: roleRef,
        usersGroupRef: usersGroupRef,
        visitorRef: visitorRef,
      );
}
