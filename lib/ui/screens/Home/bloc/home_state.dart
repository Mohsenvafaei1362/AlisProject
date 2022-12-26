part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final AppException exception;
  const HomeError({required this.exception});
  @override
  List<Object> get props => [exception];
}

class HomeSuccess extends HomeState {
  final List<ProductEntity> products;
  final List<ProductEntity> proposal;
  final List<ProductEntity> bestselling;
  final List<SliderInfo> banners1;
  final List<SliderInfo> banners2;
  final List<SliderInfo> banners3;
  final List<MessageCount> messageCount;
  final List<ClubInfo> club;
  final List<GholeInfo> ghole;
  final List<SliderInfo> slider;
  final List<TopPepoleInfo> topPepole;
  final List<FestivalInfo> festival;
  final List<RaceInfo> race;
  final List<SurveyInfo> survey;
  const HomeSuccess({
    required this.products,
    required this.banners1,
    required this.banners2,
    required this.banners3,
    required this.messageCount,
    required this.club,
    required this.ghole,
    required this.slider,
    required this.proposal,
    required this.bestselling,
    required this.topPepole,
    required this.festival,
    required this.race,
    required this.survey,
  });
}
