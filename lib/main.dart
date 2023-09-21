// main.dart

// ignore_for_file: deprecated_member_use

import 'package:adecco_ahmad_test/colors.dart';
import 'package:adecco_ahmad_test/dimentions.dart';
import 'package:adecco_ahmad_test/home/views/home_view.dart';
import 'package:adecco_ahmad_test/login/viewmodels/login_viewmodel.dart';
import 'package:adecco_ahmad_test/login/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.read(loginViewModelProvider).loadToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Adecco Ahmad Test',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme:
              ThemeData().colorScheme.copyWith(primary: AppColors.colorpalette),
          primaryColor: AppColors.colorpalette,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  // primary: ConstColors.BLACK,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Dimentions.MAIN_RADUIS)),
                  padding: const EdgeInsets.all(Dimentions.MAIN_PADDING),
                  textStyle: const TextStyle(
                      fontFamily: 'primary',
                      letterSpacing: 1.1,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold))),
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 36,
                letterSpacing: 1.1,
                fontWeight: FontWeight.bold,
                color: AppColors.COLOR_WHITE),
            headline2: TextStyle(
                fontSize: 20,
                letterSpacing: 1.1,
                fontWeight: FontWeight.bold,
                color: AppColors.colorpalette),
            headline3: TextStyle(
                fontSize: 18,
                letterSpacing: 1.1,
                height: 1,
                fontWeight: FontWeight.normal,
                color: AppColors.colorpalette),
            bodyText1: TextStyle(
                fontSize: 16.0,
                letterSpacing: 1.1,
                fontWeight: FontWeight.normal,
                color: AppColors.COLOR_GRAY),
          ),
          inputDecorationTheme: const InputDecorationTheme(
              fillColor: AppColors.COLOR_LIGHT_GRAY,
              filled: true,
              iconColor: AppColors.colorpalette,
              labelStyle: TextStyle(color: AppColors.colorpalette),
              contentPadding: EdgeInsets.all(Dimentions.MINI_PADDING),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorpalette),
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimentions.MAIN_RADUIS))),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorpalette),
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimentions.MAIN_RADUIS))),
              disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorpalette),
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimentions.MAIN_RADUIS))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.colorpalette),
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimentions.MAIN_RADUIS)))),
        ),
        home: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 3), () {
            return true;
          }),
          builder: (context, snapshot) {
            if (snapshot.hasData) return const WrapperScreen();
            return const LoadingScreen();
          },
        ));
  }
}

class WrapperScreen extends ConsumerWidget {
  const WrapperScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var loginViewModel = ref.watch(loginViewModelProvider);

    if (loginViewModel.token == null) return const LoginView();
    return const HomeView();
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            FlutterLogo(size: 220.0, style: FlutterLogoStyle.horizontal),
            SizedBox(height: Dimentions.MAIN_DIMN),
            CircularProgressIndicator(
              strokeWidth: 2,
            ),
          ],
        ),
      ),
    );
  }
}
