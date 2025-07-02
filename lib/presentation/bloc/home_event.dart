

part of "home_bloc.dart";

@immutable
abstract class HomeEvent{}

final class LoadDogListEvent extends HomeEvent{

}

final class UploadDogImageEvent extends HomeEvent{}

final class PickImageFromGalleryEvent extends HomeEvent{}

class RefreshDogListEvent extends HomeEvent{}