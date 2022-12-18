import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/CommentProduct_data_source.dart';

final commentProductRepository =
    CommentProductRepository(CommentProductDataSource(httpClient));

abstract class ICommentProductRepository {
  Future<void> commentProduct(
    String txt1,
    String txt2,
    String txt3,
    String txt4,
  );
}

class CommentProductRepository implements ICommentProductRepository {
  final ICommentProductDataSource dataSource;

  CommentProductRepository(this.dataSource);
  @override
  Future<void> commentProduct(
          String txt1, String txt2, String txt3, String txt4) =>
      dataSource.commentProduct(
        txt1,
        txt2,
        txt3,
        txt4,
      );
}
