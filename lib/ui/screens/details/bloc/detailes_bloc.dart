import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'detailes_event.dart';
part 'detailes_state.dart';

class DetailesBloc extends Bloc<DetailesEvent, DetailesState> {
  final IProductRepository productRepository;
  DetailesBloc({required this.productRepository}) : super(DetailesInitial()) {
    on<DetailesEvent>((event, emit) async {
      try {
        if (event is DetailesStarted) {
          emit(DetailesLoading());
          final response = await productRepository.detail(event.data);
          emit(DetailesSuccess(response));
        }
      } catch (e) {
        emit(DetailesError(AppException()));
      }
    });
  }
}
