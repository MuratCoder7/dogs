import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cat_app_with_bloc/data/models/dog_list_res.dart';
import 'package:my_cat_app_with_bloc/presentation/bloc/home_bloc.dart';
import 'package:my_cat_app_with_bloc/presentation/pages/upload_page.dart';
import 'package:my_cat_app_with_bloc/presentation/widgets/item_of_dog.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc homeBloc;
  ScrollController scrollController = ScrollController();

  _callUploadPage()async{
    var result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context){
        return UploadPage();
      })
    );
    if(result==true){
      homeBloc.add(RefreshDogListEvent());
    }
  }


  @override
  void initState(){
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(LoadDogListEvent());
    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent<=scrollController.offset){
        homeBloc.add(LoadDogListEvent());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:BlocConsumer<HomeBloc,HomeState>(
        listener: (context,state){},
        buildWhen: (previous,current){
          return current is HomeSuccessState;
        },
        builder: (context,state){
          if(state is HomeErrorState){
            return viewOfError(state.errorMessage);
          }else if (state is HomeSuccessState){
           var dogs = state.dogs;
           if(dogs.isEmpty){
             return Center(
               child: Text("No Images "),
             );
           }
           return viewOfDogList(dogs);
          }
            return viewOfLoading();

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _callUploadPage();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
    );
  }


  Widget viewOfError(String error){
    return Center(
      child: Text("Error occurred"),
    );
  }

  Widget viewOfLoading(){
    return Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }



  Widget viewOfDogList(List<DogListRes> dogs){
    return RefreshIndicator(
    onRefresh: ()async{
      homeBloc.add(RefreshDogListEvent());
    },
           child:ListView.builder(
             controller: scrollController,
     itemCount: dogs.length,
     itemBuilder: (context,index){
       return itemOfDog(dogs[index]);
     },) ,
        );
  }

}
