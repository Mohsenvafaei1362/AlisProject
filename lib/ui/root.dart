import 'package:local_notification_flutter_project/ui/data/repo/cart_repository.dart';
import 'package:local_notification_flutter_project/ui/screens/Category/category.dart';
import 'package:local_notification_flutter_project/ui/screens/Home/home.dart';
import 'package:local_notification_flutter_project/ui/screens/Profile/profile.dart';
import 'package:local_notification_flutter_project/ui/screens/cart/cart.dart';
import 'package:local_notification_flutter_project/ui/screens/widgets/badge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

const int homeIndex = 0;
const int categoryIndex = 1;
const int cartIndex = 2;
const int profileIndex = 3;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  final GlobalKey<NavigatorState> _categoryKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
    categoryIndex: _categoryKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  void initState() {
    cartRepository.count();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(
            index: selectedScreenIndex,
            children: [
              _navigator(_homeKey, homeIndex, HomeScreen_Ui()),
              _navigator(
                  _categoryKey,
                  categoryIndex,
                  Center(
                    child: Category(size: size),
                  )),
              _navigator(
                  _cartKey,
                  cartIndex,
                  const Center(
                    child: CartScreen(),
                  )),
              _navigator(
                  _profileKey,
                  profileIndex,
                  const Center(
                    child: Profile(),
                  )),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: Colors.grey,
            iconSize: 25,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.home), label: 'خانه'),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.rectangle_grid_2x2),
                  label: 'دسته بندی'),
              BottomNavigationBarItem(
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(CupertinoIcons.cart),
                    Positioned(
                      top: -5,
                      right: -15,
                      child: ValueListenableBuilder<String>(
                        valueListenable: CartRepository.cartItemCountNotifier,
                        builder: (BuildContext context, value, Widget? child) {
                          // return Text(
                          //   value.toString().toPersianDigit(),
                          // );
                          return Badge(
                            value: value.toPersianDigit(),
                          );
                        },
                        child: const Badge(value: '2'),
                      ),
                    ),
                  ],
                ),
                label: 'سبد خرید',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'پروفایل'),
            ],
            currentIndex: selectedScreenIndex,
            onTap: (selectedIndex) {
              setState(() {
                _history.remove(selectedScreenIndex);
                _history.add(selectedScreenIndex);
                selectedScreenIndex = selectedIndex;
              });
            },
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
