import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cat_app_with_bloc/presentation/bloc/home_bloc.dart';
import 'package:my_cat_app_with_bloc/presentation/pages/home_page.dart';

void main(){
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return   MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context)=>HomeBloc(),
          ),
        ],
        child: MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        ),);
  }
}
