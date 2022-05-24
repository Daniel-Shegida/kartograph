import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/debug_options.dart';
import 'package:kartograph/config/environment/build_types.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/config/urls.dart';
import 'package:kartograph/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.release,
    config: AppConfig(
      url: Url.prodUrl,
      proxyUrl: Url.prodProxyUrl,
      debugOptions: DebugOptions(),
    ),
  );

  run();
}
