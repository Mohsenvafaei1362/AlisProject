import 'package:local_notification_flutter_project/ui/data/ClassInfo/Club_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/Ghole_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/banner.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/festival.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/message_box_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/product.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/race_info.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/sliderInfo.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/survey.dart';
import 'package:local_notification_flutter_project/ui/data/ClassInfo/topPepole.dart';
import 'package:local_notification_flutter_project/ui/data/common/exception.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Club_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/Ghole_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/bannerRepository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/festival_Repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/message_box_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/product_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/race_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/slider_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/survey_repository.dart';
import 'package:local_notification_flutter_project/ui/data/repo/topPepole_repository.dart';
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
var proposals;
var bestsellings;
var topPepole;
var festival;
var race;
var survey;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepository productRepository;
  final IUserInfoRepository userInfoRepository;
  final IMessageCountRepository messageCountRepository;
  final IClubRepository clubRepository;
  final IGholeRepository gholeRepository;
  final ISliderRepository sliderRepository;
  final ITopPepoleRepository topPepoleRepository;
  final IFestivalRepository festivalRepository;
  final IRaceRepository raceRepository;
  final ISurveyRepository surveyRepository;
  HomeBloc({
    required this.bannerRepository,
    required this.productRepository,
    required this.userInfoRepository,
    required this.messageCountRepository,
    required this.clubRepository,
    required this.gholeRepository,
    required this.sliderRepository,
    required this.topPepoleRepository,
    required this.festivalRepository,
    required this.raceRepository,
    required this.surveyRepository,
  }) : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final products = await productRepository.getAll(
            categoryId: 0,
            modelId: 0,
            model: 'allProduct',
          ); // همه محصولات
          final proposal = await productRepository.getAll(
            categoryId: 0,
            modelId: 0,
            model: 'proposal',
          ); //پیشنهاد ویژه
          final bestselling = await productRepository.getAll(
            categoryId: 0,
            modelId: 0,
            model: 'bestselling',
          ); // پر فروش ترین
          final banners = await bannerRepository.getAll(); //تبلیغات
          final messageCount =
              await messageCountRepository.messageCount(); //پیام
          final clubinfo = await clubRepository.club(); //باشگاه
          final gholeinfo = await gholeRepository.ghole(); //قله
          final sliderInfo = await sliderRepository.getImage('Main'); //اسلایدر
          final topPepoles =
              await topPepoleRepository.topPepole(); //سه نفر برتر
          final festivals = await festivalRepository.festival(); //جشنواره
          final races = await raceRepository.race(); //مسابقات
          final surveys = await surveyRepository.surveyList(); //نظر سنجی

          // final userInfo = await userInfoRepository.userInfo();
          product = products;
          banner = banners;
          message = messageCount;
          club = clubinfo;
          ghole = gholeinfo;
          slider = sliderInfo;
          proposals = proposal;
          bestsellings = bestselling;
          topPepole = topPepoles;
          festival = festivals;
          race = races;
          survey = surveys;

          // user = userInfo;
          // await loadCartItems(emit, false);
          // final popularProducts = await productRepository.getAll();
          emit(HomeSuccess(
            banners: banners,
            products: products,
            messageCount: message,
            club: clubinfo,
            ghole: gholeinfo,
            slider: sliderInfo,
            bestselling: bestselling,
            proposal: proposal,
            topPepole: topPepoles,
            festival: festivals,
            race: races,
            survey: surveys,
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
      final result = await productRepository.getAll(
        categoryId: 1,
        modelId: 1,
        model: '',
      );
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
          bestselling: bestsellings,
          proposal: proposals,
          topPepole: topPepole,
          festival: festival,
          race: race,
          survey: survey,
        ));
      }
    } catch (e) {
      emit(HomeError(exception: AppException()));
    }
  }
}
