import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/global/controllers/theme_controller.dart';
import 'presentation/global/theme/cinexa_theme.dart';
import 'presentation/routes/app_routes.dart';
import 'presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: 'Cinexa',
        debugShowCheckedModeBanner: false,
        theme: CinexaTheme.light(),
        darkTheme: CinexaTheme.dark(),
        themeMode: themeController.mode,
        initialRoute: Routes.splash,
        routes: appRoutes,
      ),
    );
  }
}
