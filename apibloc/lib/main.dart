import 'package:apibloc/bloc/bloc.dart';
import 'package:apibloc/bloc/event.dart';
import 'package:apibloc/screens/read.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (context) => StudentBloc()..add(getStudent()),
        child: const readRequest(),
      ),
    );
  }
}
