import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/debug_options.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/features/app/di/app_scope.dart';
import 'package:kartograph/features/app/di/theme_provider.dart';
import 'package:kartograph/features/common/widgets/di_scope/di_scope.dart';
import 'package:kartograph/features/navigation/domain/entity/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:routemaster/routemaster.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance App.
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();

    _scope = AppScope(applicationRebuilder: _rebuildApplication);
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp.router(
            /// Localization.
            locale: _localizations.first,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: _localizations,

            /// Debug configuration.
            showPerformanceOverlay: _getDebugConfig().showPerformanceOverlay,
            debugShowMaterialGrid: _getDebugConfig().debugShowMaterialGrid,
            checkerboardRasterCacheImages:
                _getDebugConfig().checkerboardRasterCacheImages,
            checkerboardOffscreenLayers:
                _getDebugConfig().checkerboardOffscreenLayers,
            showSemanticsDebugger: _getDebugConfig().showSemanticsDebugger,
            debugShowCheckedModeBanner:
                _getDebugConfig().debugShowCheckedModeBanner,

            /// This is for navigation.
            routeInformationParser: const RoutemasterParser(),
            routerDelegate: RoutemasterDelegate(routesBuilder: (_) => routes),

            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
          );
        },
      ),
    );
  }

  DebugOptions _getDebugConfig() {
    return Environment<AppConfig>.instance().config.debugOptions;
  }

  void _rebuildApplication() {
    setState(() {
      _scope = AppScope(applicationRebuilder: _rebuildApplication);
    });
  }
}

// You need to customize for your project.
const _localizations = [Locale('ru', 'RU')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
