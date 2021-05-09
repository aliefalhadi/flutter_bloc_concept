import 'package:bloc_concept/configs/app_router.dart';
import 'package:bloc_concept/logic/cubit/counter_cubit.dart';
import 'package:bloc_concept/logic/cubit/internet_cubit.dart';
import 'package:bloc_concept/presentation/views/home.dart';
import 'package:bloc_concept/presentation/views/home_second.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
      appRouter: AppRouter(),
      connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => InternetCubit(connectivity: connectivity)
          ),
          BlocProvider(create: (context) => CounterCubit())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: appRouter.onGenerateRoute,
        )
    );
  }
}
