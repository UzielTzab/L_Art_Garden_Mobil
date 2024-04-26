import 'package:flutter/material.dart';
import 'package:l_art_garden_mobil/Screens/login_screen.dart';
import 'package:l_art_garden_mobil/Screens/main_store.dart';
import 'package:l_art_garden_mobil/Screens/register.dart';
import 'package:l_art_garden_mobil/Screens/welcome.dart';
import 'package:l_art_garden_mobil/model_provider/adress_provider.dart';
import 'package:l_art_garden_mobil/model_provider/cartListProvider.dart';
import 'package:l_art_garden_mobil/model_provider/counter_cart.dart';
import 'package:l_art_garden_mobil/model_provider/flower_shops_provider.dart';
import 'package:l_art_garden_mobil/model_provider/products_provider.dart';
import 'package:l_art_garden_mobil/model_provider/text_filter_products.dart';
import 'package:l_art_garden_mobil/model_provider/users_provider.dart';
import 'package:provider/provider.dart';
import './model_provider/favorites_provider.dart';
import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MainClassLArtGarden());
  });
}

class MainClassLArtGarden extends StatefulWidget {
  const MainClassLArtGarden({super.key});

  @override
  State<MainClassLArtGarden> createState() => _MainClassLArtGardenState();
}

class _MainClassLArtGardenState extends State<MainClassLArtGarden> {
  Soundpool pool = Soundpool.fromOptions(
    options: const SoundpoolOptions(streamType: StreamType.music),
  );

  @override
  void initState() {
    super.initState();
    loadAndPlaySound();
  }

  Future<void> loadAndPlaySound() async {
    int soundId = await rootBundle
        .load("assets/sounds/L-Art-Garden-Sounds.mp3")
        .then((ByteData soundData) {
      return pool.load(soundData);
    });
    await pool.play(soundId);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FlowerShopProvider()),
          ChangeNotifierProvider(create: (_) => SearchProvider()),
          ChangeNotifierProvider(create: (_) => AddressProvider()),
          ChangeNotifierProvider(create: (_) => CartListProvider()),
          ChangeNotifierProvider(create: (_) => FavoritesProvider()),
          ChangeNotifierProvider(create: (_) => CounterCartProvider()),
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
        ],
        builder: (context, _) {
          final GlobalKey<NavigatorState> navigatorKey =
              GlobalKey<NavigatorState>();
          return MaterialApp(
            navigatorKey: navigatorKey,
            initialRoute: '/',
            routes: {
              '/': (context) => const Welcome(),
              '/MainStore': (context) => const MainStore(),
              '/LoginScreen': (context) => const LoginScreen(),
              '/RegisterScreen': (context) => const registerScreen(),
            },
            theme: ThemeData(
                textTheme: const TextTheme(
                    titleLarge: TextStyle(fontFamily: 'Capri'),
                    titleMedium: TextStyle(fontFamily: 'Capri'),
                    titleSmall: TextStyle(fontFamily: 'Capri'),
                    bodyLarge: TextStyle(fontFamily: 'Capri'),
                    bodyMedium: TextStyle(fontFamily: 'Capri'),
                    labelLarge: TextStyle(fontFamily: 'Capri'),
                    labelMedium: TextStyle(fontFamily: 'Capri'),
                    labelSmall: TextStyle(fontFamily: 'Capri')),
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 241, 221, 167)),
                useMaterial3: true),
            color: const Color.fromARGB(255, 237, 145, 88),
            debugShowCheckedModeBanner: false,
            title: 'L Art Garden',
          );
        });
  }
}
