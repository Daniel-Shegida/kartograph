import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/features/navigation/domain/entity/app_route_paths.dart';
import 'package:kartograph/features/navigation/domain/entity/app_routes.dart';
import 'package:kartograph/features/navigation/service/router.dart';
import 'package:kartograph/features/navigation/widget/bottom_sheet.dart';
import 'package:kartograph/util/default_error_handler.dart';

/// Scope of dependencies which need through all app's life.
class AppScope implements IAppScope {
  late final Dio _dio;
  late final ErrorHandler _errorHandler;
  late final VoidCallback _applicationRebuilder;
  late final AppRouter _router;

  @override
  Dio get dio => _dio;

  @override
  ErrorHandler get errorHandler => _errorHandler;

  @override
  VoidCallback get applicationRebuilder => _applicationRebuilder;

  @override
  AppRouter get router => _router;

  /// Create an instance [AppScope].
  AppScope({
    required VoidCallback applicationRebuilder,
  }) : _applicationRebuilder = applicationRebuilder {
    /// List interceptor. Fill in as needed.
    final additionalInterceptors = <Interceptor>[];

    _dio = _initDio(additionalInterceptors);
    _errorHandler = DefaultErrorHandler();
    _router = AppRouter(
      delegate: AppRoutes(),
      initialLocation: AppRoutePaths.tempScreen,
      navigatorBuilder:
          (context, state, child) =>
              Navigator(
                // если убрать - ошибка
                // ignore: avoid_annotating_with_dynamic
        onPopPage: (route, dynamic result) {
          route.didPop(result);
          return false; // don't pop the single page on the root navigator
        },
        pages: [
          MaterialPage<void>(
            child: BottomNavigator(
              selectedIndex: _pickBottom(state.subloc),
              body: child,
            ),
          ),
        ],
      ),
    );
  }

  int _pickBottom(String stateSubloc) {
    switch (stateSubloc) {
      case AppRoutePaths.placesScreen:
        return 0;
      case AppRoutePaths.mapScreen:
        return 1;
      case AppRoutePaths.settingScreen:
        return 2;
    }
    return 1;
  }

  Dio _initDio(Iterable<Interceptor> additionalInterceptors) {
    const timeout = Duration(seconds: 30);

    final dio = Dio();

    dio.options
      ..baseUrl = Environment<AppConfig>.instance().config.url
      ..connectTimeout = timeout.inMilliseconds
      ..receiveTimeout = timeout.inMilliseconds
      ..sendTimeout = timeout.inMilliseconds;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      final proxyUrl = Environment<AppConfig>.instance().config.proxyUrl;
      if (proxyUrl != null && proxyUrl.isNotEmpty) {
        client
          ..findProxy = (uri) {
            return 'PROXY $proxyUrl';
          }
          ..badCertificateCallback = (_, __, ___) {
            return true;
          };
      }

      return client;
    };

    dio.interceptors.addAll(additionalInterceptors);

    if (Environment<AppConfig>.instance().isDebug) {
      dio.interceptors
          .add(LogInterceptor(requestBody: true, responseBody: true));
    }

    return dio;
  }
}

/// App dependencies.
abstract class IAppScope {
  /// Http client.
  Dio get dio;

  /// Interface for handle error in business logic.
  ErrorHandler get errorHandler;

  /// Callback to rebuild the whole application.
  VoidCallback get applicationRebuilder;

  /// Class that coordinates navigation for the whole app.
  AppRouter get router;
}

// class SharedScaffold extends StatefulWidget {
//   const SharedScaffold({
//     required this.selectedIndex,
//     required this.body,
//     Key? key,
//   }) : super(key: key);
//
//   final int selectedIndex;
//   final Widget body;
//
//   @override
//   State<SharedScaffold> createState() => _SharedScaffoldState();
// }
//
// class _SharedScaffoldState extends State<SharedScaffold> {
//   @override
//   Widget build(BuildContext context) => AdaptiveNavigationScaffold(
//     selectedIndex: widget.selectedIndex,
//     destinations: const [
//       AdaptiveScaffoldDestination(title: 'Page 1', icon: Icons.first_page),
//       AdaptiveScaffoldDestination(title: 'Page 2', icon: Icons.last_page),
//       AdaptiveScaffoldDestination(title: 'About', icon: Icons.info),
//     ],
//     // appBar: AdaptiveAppBar(title: const Text("App.title")),
//     navigationTypeResolver: (context) =>
//     _drawerSize ? NavigationType.drawer : NavigationType.bottom,
//     onDestinationSelected: (index) async {
//       // if there's a drawer, close it
//       if (_drawerSize) Navigator.pop(context);
//
//       switch (index) {
//         case 0:
//           context.go('/');
//           break;
//         case 1:
//           context.go('/page2');
//           break;
//         // case 2:
//         //   final packageInfo = await PackageInfo.fromPlatform();
//         //   showAboutDialog(
//         //     context: context,
//         //     applicationName: packageInfo.appName,
//         //     applicationVersion: 'v${packageInfo.version}',
//         //     applicationLegalese: 'Copyright © 2022, Acme, Corp.',
//         //   );
//         //   break;
//         default:
//           throw Exception('Invalid index');
//       }
//     },
//     body: widget.body,
//   );
//
//   bool get _drawerSize => MediaQuery.of(context).size.width >= 600;
// }
