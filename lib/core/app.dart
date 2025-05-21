import 'package:catbreeds/modules/home/application/home/cat_bloc.dart';
import 'package:catbreeds/modules/home/infrastructure/the_cat_api_repository.dart';
import 'package:catbreeds/modules/home/presentation/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [BlocProvider(create: (context) => CatBloc(catRepository: TheCatApiRepository()))], child: const AppView());
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal, scaffoldBackgroundColor: Colors.white, fontFamily: 'Roboto'),
      home: LandingPage(),
    );
  }
}
