import 'package:controle_estoque_amostras_app/2-base/utils/instances.dart';
import 'package:flutter/widgets.dart';

class MenuController extends ChangeNotifier {
  late ValueNotifier<int> _selectedPage;
  late final PageController _pageController;

  MenuController() {
    _selectedPage = ValueNotifier<int>(0);
    _pageController = PageController(initialPage: _selectedPage.value)..addListener(pageSelectedListener);
  }

  //Getters
  ValueNotifier<int> get selectedPage => _selectedPage;
  PageController get pageController => _pageController;

  void pageSelectedListener() {
    try {
      //Verificar qual a pagina atual e setar o path do svg correspondente
      final page = int.parse((pageController.page?.round() ?? 0).toString());
      _selectedPage.value = page;
    } catch (_) {
      _selectedPage.value = 0;
    } finally {
      notifyListeners();
    }
  }

  void changePage(int index) {
    _selectedPage.value = index;
    _pageController.jumpToPage(index);
    notifyListeners();
  }

  Future<void> goToAddRegisterPage() async {
    changePage(1);
    addRegisterController.resetVariables();
    return addRegisterController.initMethods();
  }
}
