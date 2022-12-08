import 'package:local_notification_flutter_project/ui/data/httpClient/httpClient.dart';
import 'package:local_notification_flutter_project/ui/data/source/documents_data_source.dart';
import 'package:local_notification_flutter_project/ui/models/Dto/DocumentsDto.dart';

final documentsRepository =
    DocumentsRepository(DocumentsRemoteDataSource(httpClient));

abstract class IDocumentsRepository {
  Future<List<UiDocumentsInfo>> imageUrl(
    UiDocumentsInfo document,
  );
}

class DocumentsRepository implements IDocumentsRepository {
  final IDocumentsDataSource dataSource;
  DocumentsRepository(this.dataSource);
  @override
  Future<List<UiDocumentsInfo>> imageUrl(
    UiDocumentsInfo document,
  ) =>
      dataSource.imageUrl(
        document,
      );
}
