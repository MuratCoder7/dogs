import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cat_app_with_bloc/data/models/dog_list_res.dart';
import 'package:my_cat_app_with_bloc/data/remote/http_service.dart';

part "home_state.dart";
part "home_event.dart";


class HomeBloc extends Bloc<HomeEvent,HomeState>{
  HomeBloc():super(HomeInitialState()){
    on<LoadDogListEvent>(_onLoadDogList);
    on<UploadDogImageEvent>(_onUploadDogImage);
    on<PickImageFromGalleryEvent>(_onPickImageFromGallery);
    on<RefreshDogListEvent>(_onRefreshDogList);
  }
  List<DogListRes> dogs = [];
  final _picker = ImagePicker();
  XFile? _image;
  int currentPage = 0;

  _loadDogListAndEmit(Emitter<HomeState>emit,{bool isRefresh=false})async{
    if(isRefresh){
      dogs.clear();
      currentPage=0;
    }
    emit(HomeLoadingState());
    try{
      var response = await HttpService.GET(HttpService.API_DOG_GET,HttpService.paramsDogList(currentPage: currentPage));
      if(response!=null){
        var result = HttpService.parseDogList(response);
        dogs.addAll(result);
        currentPage++;
        return emit(HomeSuccessState(dogs: dogs));
      }
    }catch(e){
      return emit(HomeErrorState(errorMessage: "Something went wrong $e"));
    }
  }

  // Event handlers
  _onLoadDogList(LoadDogListEvent event,Emitter<HomeState>emit)async{
    await _loadDogListAndEmit(emit);
  }

  _onPickImageFromGallery(PickImageFromGalleryEvent event,Emitter<HomeState>emit)async{
    emit(HomeLoadingState());
    try{
      _image  =  await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 100,
        maxWidth:1024,
        maxHeight: 1024,
      );
      if(_image!=null){
        await Future.delayed(Duration(seconds: 1));
        return emit(PickSuccessState(image: _image));
      }
    }catch(e){
      return emit(HomeErrorState(errorMessage: "Something went wrong $e"));
    }
  }


  _onUploadDogImage(UploadDogImageEvent event,Emitter<HomeState>emit)async{
    emit(HomeLoadingState());
   try{
     if(_image==null)return emit(HomeErrorState(errorMessage: "Please choose an Image"));
     if(_image!=null){
       var imageFile = File(_image!.path);
        await HttpService.MUL(HttpService.API_DOG_UPLOAD,
           imageFile,HttpService.paramsEmpty());
        return emit(UploadSuccessState());
     }
   }catch(e){
     return emit(HomeErrorState(errorMessage: "Something went wrong $e"));
   }
  }

  _onRefreshDogList(RefreshDogListEvent event,Emitter<HomeState>emit)async{
    await _loadDogListAndEmit(emit,isRefresh: true);
  }
}