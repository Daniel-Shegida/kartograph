import 'package:kartograph/config/app_config.dart';
import 'package:kartograph/config/coordinates.dart';
import 'package:kartograph/config/debug_options.dart';
import 'package:kartograph/config/environment/build_types.dart';
import 'package:kartograph/config/environment/environment.dart';
import 'package:kartograph/config/urls.dart';
import 'package:kartograph/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.qa,
    config: AppConfig(
      url: Url.testUrl,
      lat: ProjectCoordinates.staringCords.latitude,
      lng: ProjectCoordinates.staringCords.longitude,
      proxyUrl: Url.qaProxyUrl,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
      ),
    ),
  );

  run();
}
