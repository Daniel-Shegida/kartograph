

import 'package:kartograph/config/debug_options.dart';

/// Настройки приложения.
class AppConfig {
  /// Url сервера.
  final String url;

  /// прокси url.
  final String? proxyUrl;

  /// показываемая широта при иницилизации .
  final double lat;

  /// показываемая долгота при иницилизации .
  final double lng;

  /// Additional application settings in debug mode.
  final DebugOptions debugOptions;

  /// Create an instance [AppConfig].
  AppConfig({
    required this.url,
    required this.lat,
    required this.lng,
    required this.debugOptions,
    this.proxyUrl,
  });

  /// Create an instance [AppConfig] with modified parameters.
  AppConfig copyWith({
    String? url,
    double? lat,
    double? lng,
    String? proxyUrl,
    DebugOptions? debugOptions,
  }) =>
      AppConfig(
        url: url ?? this.url,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        proxyUrl: proxyUrl ?? this.proxyUrl,
        debugOptions: debugOptions ?? this.debugOptions,
      );
}
