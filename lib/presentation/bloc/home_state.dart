

part of "home_bloc.dart";

@immutable
abstract class HomeState{}
final class HomeInitialState extends HomeState{}
final class HomeLoadingState extends HomeState{}
final class HomeSuccessState extends HomeState{
  final List<DogListRes> dogs;
  HomeSuccessState({required this.dogs});
}
final class HomeErrorState extends HomeState{
  final String errorMessage;
  HomeErrorState({required this.errorMessage});
}

final class PickSuccessState extends HomeState{
  final XFile? image;
  PickSuccessState(
  {
    required this.image,
});
}

final class UploadSuccessState extends HomeState{}