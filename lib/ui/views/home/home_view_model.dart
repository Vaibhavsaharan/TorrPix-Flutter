import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:torrpix/app/app.locator.dart';
import 'package:torrpix/app/app.router.dart';


class HomeViewModel extends BaseViewModel{
  final _navigationService = locator<NavigationService>();

  goToSearchView (){
    _navigationService.navigateTo(Routes.searchView);
  }
}