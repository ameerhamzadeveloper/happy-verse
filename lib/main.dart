import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hapiverse/logic/chat/chat_cubit.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:hapiverse/logic/places/places_cubit.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/logic/story/story_cubit.dart';
import 'package:hapiverse/routes/custom_routes.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/language_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findRootAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }
}


class _MyAppState extends State<MyApp> {
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  Locale? _locale;


  getSharedLanguages()async{
    const loc = Locale('ar', 'SA');
    SharedPreferences pre = await SharedPreferences.getInstance();
    var cLan = pre.getInt('language');
    if(cLan == 0){
      const local = Locale('en', 'US');
      setLocale(local);
    }else if(cLan == 1){
      const local = Locale('zh', 'CN');
      MyApp.setLocale(context, local);
    }else if(cLan == 2){
      const local = Locale('ar', 'SA');
      setLocale(local);
    }else if(cLan == 3){
      const local = Locale('ur', 'PK');
      setLocale(local);
    }else if(cLan == 4){
      const local = Locale('hi', 'IN');
      setLocale(local);
    }
    else if(cLan == 5){
      const local = Locale('es', 'ES');
      setLocale(local);
    }

  }

  @override
  void initState() {
    super.initState();
    getSharedLanguages();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
        BlocProvider<StoryCubit>(create: (context) => StoryCubit()),
        BlocProvider<PostCubit>(create: (context) => PostCubit()),
        BlocProvider<GroupsCubit>(create: (context) => GroupsCubit()),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<FeedsCubit>(create: (context) => FeedsCubit()),
        BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
        BlocProvider<PlacesCubit>(create: (context) => PlacesCubit()),
      ],
      child: MaterialApp(
        supportedLocales: const [
          Locale('ar', 'SA'),
          Locale('en', 'US'),
          Locale("zh", "CN"),
          Locale("hi", "IN"),
          Locale("ur", "PK"),
          Locale("es", "ES"),
        ],
        locale: _locale,
        localizationsDelegates: const [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: 'hapiverse',
        theme: ThemeData(
          scaffoldBackgroundColor: kScaffoldBgColor,
          appBarTheme: const AppBarTheme(
            elevation: 0.0,
            backgroundColor: kUniversalColor,
            centerTitle: true,
          ),
          fontFamily: 'Delecta',
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(secondary: kSecendoryColor, primary: kUniversalColor),
          primarySwatch: Colors.blue,
        ),
        initialRoute: splashNormal,
        onGenerateRoute: CustomRoutes.allRoutes,
      ),
    );
  }
}
