import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/bannerRepository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/slider_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/user_info_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

var product;
var banner;
var user;
var message;
var club;
var ghole;
var slider;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  final IUserInfoRepository userInfoRepository;
  final IMessageCountRepository messageCountRepository;
  final IClubRepository clubRepository;
  final IGholeRepository gholeRepository;
  final ISliderRepository sliderRepository;
  HomeBloc({
    required this.bannerRepository,
    required this.productRepository,
    required this.userInfoRepository,
    required this.messageCountRepository,
    required this.clubRepository,
    required this.gholeRepository,
    required this.sliderRepository,
  }) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final latestProducts = await productRepository.getAll();
          final banners = await bannerRepository.getAll();
          final messageCount = await messageCountRepository.messageCount();
          final clubinfo = await clubRepository.club();
          final gholeinfo = await gholeRepository.ghole();
          final sliderInfo = await sliderRepository.getImage('Main');

          // final userInfo = await userInfoRepository.userInfo();
          product = latestProducts;
          banner = banners;
          message = messageCount;
          club = clubinfo;
          ghole = gholeinfo;
          slider = sliderInfo;

          // user = userInfo;
          // await loadCartItems(emit, false);
          // final popularProducts = await productRepository.getAll();
          emit(HomeSuccess(
            banners: banners,
            products: latestProducts,
            messageCount: message,
            club: clubinfo,
            ghole: gholeinfo,
            slider: sliderInfo,
            // userInfo: user,
            // popularProducts: popularProducts
          ));
        } catch (e) {
          emit(HomeError(exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
  Future<void> loadCartItems(Emitter<HomeState> emit, bool isRefreshing) async {
    try {
      if (!isRefreshing) {
        emit(HomeLoading());
      }
      final result = await productRepository.getAll();
      final banners = await bannerRepository.getAll();
      final messageCount = await messageCountRepository.messageCount();
      if (result.isEmpty || banners.isEmpty || messageCount.isEmpty) {
        emit(HomeLoading());
      } else {
        emit(HomeSuccess(
          products: result,
          banners: banners,
          messageCount: messageCount,
          club: club,
          ghole: ghole,
          slider: slider,
        ));
      }
    } catch (e) {
      emit(HomeError(exception: AppException()));
    }
  }
}
