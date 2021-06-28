import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:torrpix/ui/views/home/home_view.dart';
import 'package:torrpix/ui/views/search/search_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: SearchView)
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ]
)
class AppSetup {}
