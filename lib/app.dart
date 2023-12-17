import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sausage_roll_app/models/cart.dart';
import 'package:sausage_roll_app/models/mode.dart';
import 'package:sausage_roll_app/views/cart_view.dart';
import 'package:sausage_roll_app/views/product_info_view.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => Mode(),
        ),
      ],
      child: MaterialApp(
          home: Scaffold(
            body: <Widget>[
              const ProductInfoView(),
              const CartView(),
            ][selectedPageIndex],
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                setState(() {
                  selectedPageIndex = index;
                });
              },
              indicatorColor: Colors.amber,
              selectedIndex: selectedPageIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.home_outlined),
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Badge(child: Icon(Icons.local_mall_outlined)),
                  icon: Badge(child: Icon(Icons.local_mall)),
                  label: 'Cart',
                )
              ],
            ),
          ),
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xFFFFF8F0),
            textTheme: Theme.of(context).textTheme.apply(
                  fontFamily: GoogleFonts.gothicA1().fontFamily,
                  bodyColor: const Color(0xFF104547),
                  displayColor: const Color(0xFF174547),
                ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFFFF8F0),
              secondary: Color(0xFF174547),
              tertiary: Color(0xFF68A691),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: const Color(0xFFFFF8F0),
              centerTitle: true,
              iconTheme: IconThemeData(
                color: const Color(0xFF174547),
                shadows: [
                  Shadow(
                    color: const Color(0xFF174547).withOpacity(0.4),
                    blurRadius: 2,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              actionsIconTheme: const IconThemeData(
                color: Color(0xFF174547),
                shadows: [],
              ),
            ),
            filledButtonTheme: FilledButtonThemeData(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xE8FFCA51)),
                foregroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF181818)),
                shadowColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF68A691)),
                iconColor:
                    MaterialStateProperty.all<Color>(const Color(0xFFFFF8F0)),
                iconSize: MaterialStateProperty.all<double>(35),
                textStyle: MaterialStateProperty.all<TextStyle>(
                  const TextStyle(
                    color: Color(0xFFFFF8F0),
                    fontSize: 25,
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                ),
                elevation: MaterialStateProperty.all<double>(3),
              ),
            ),
            iconButtonTheme: IconButtonThemeData(
              style: ButtonStyle(
                shadowColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF174547)),
                iconColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF174547)),
              ),
            ),
          ),
          routes: {
            "/product-info-view": (context) => const ProductInfoView(),
            "/checkout-view": (context) => const CartView(),
          }),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
}
