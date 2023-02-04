import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_3bee/blocs/home/home_bloc.dart';
import 'package:test_3bee/blocs/login/login_bloc.dart';
import 'package:test_3bee/core/local_cache.dart';
import 'package:test_3bee/screens/home_page.dart';
import 'package:test_3bee/screens/login_page.dart';
import 'package:test_3bee/screens/main_page.dart';
import 'package:test_3bee/services/apiary_service.dart';
import 'package:test_3bee/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  final LocalCache localCache = LocalCache(preferences: preferences);

  GetIt.instance.registerLazySingleton<AuthService>(() => AuthService());
  GetIt.instance.registerLazySingleton<ApiaryService>(() => ApiaryService());
  GetIt.instance.registerSingleton<LocalCache>(localCache);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (_) => LoginBloc()),
        BlocProvider<HomeBloc>(create: (_) => HomeBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const MainPage(),
          '/login': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
        },
      ),
    );
  }
}
