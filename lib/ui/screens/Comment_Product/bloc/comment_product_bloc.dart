import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/CommentProduct_repository.dart';

part 'comment_product_event.dart';
part 'comment_product_state.dart';

class CommentProductBloc
    extends Bloc<CommentProductEvent, CommentProductState> {
  final ICommentProductRepository commentProductRepository;
  CommentProductBloc({required this.commentProductRepository})
      : super(CommentProductInitial()) {
    on<CommentProductEvent>((event, emit) async {
      try {
        if (event is CommentProductClickdButton) {
          emit(CommentProductLoading());
          final response = await this.commentProductRepository.commentProduct(
                event.txt1,
                event.txt2,
                event.txt3,
                event.txt4,
              );
          emit(CommentProductSuccess());
        }
      } catch (e) {
        emit(CommentProductError(AppException()));
      }
    });
  }
}
