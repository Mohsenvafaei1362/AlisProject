import 'package:local_notification_flutter_project/ui/data/ClassInfo/category_info.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/category_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

var category;

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ICategoryRepository categoryRepository;
  CategoryBloc({required this.categoryRepository}) : super(CategoryLoading()) {
    on<CategoryEvent>((event, emit) async {
      try {
        if (event is CategoryStarted) {
          emit(CategoryLoading());
          category = await categoryRepository.categoryImage();
          await loadCartItems(emit, event.isRefreshing);
          emit(CategorySuccess(category));
        }
      } catch (e) {
        emit(CategoryError(AppException()));
      }
    });
  }
  Future<void> loadCartItems(
      Emitter<CategoryState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(CategoryLoading());
      }
      final result = await categoryRepository.categoryImage();
      if (result.isEmpty) {
        emit(CategoryLoading());
      } else {
        emit(CategorySuccess(category));
      }
    } catch (e) {
      emit(CategoryError(AppException()));
    }
  }
}
