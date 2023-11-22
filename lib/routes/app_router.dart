import 'package:liaz/app/app_string.dart';
import 'package:liaz/modules/home/home_page.dart';
import 'package:liaz/routes/app_route_path.dart';

class AppRouter {
  static final routes = {
    AppRoutePath.kHome: (context) => const HomePage(title: AppString.appName),
  };
}