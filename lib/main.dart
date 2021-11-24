import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/home/home_page.dart';
import 'package:task/home/logic/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(create: (context) => HomeBloc()),
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomePage()),
    );
  }
}
