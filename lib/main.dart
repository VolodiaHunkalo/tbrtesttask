import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tbrtesttask/pages/main_page.dart';
import 'package:tbrtesttask/repositories/database_repository.dart';

import 'blocs/database_bloc/database_bloc.dart';
import 'database/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
            create: (context) => DatabaseBloc(
                  DatabaseRepo(
                    DatabaseProvider(),
                  ),
                )..add(
                    InitialFetchEvent(),
                  ))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const CustomCountryCodePicker()),
    );
  }
}
