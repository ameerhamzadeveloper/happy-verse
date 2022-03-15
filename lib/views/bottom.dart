import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hapiverse/views/places.dart';
import 'package:hapiverse/views/places/places.dart';
import 'package:hapiverse/views/profile/my_profile.dart';
import 'package:line_icons/line_icons.dart';

import '../utils/constants.dart';
import 'chat/chat_page.dart';
import 'feeds/feeds.dart';
import 'groups/groups.dart';
class BottomNavBaaar extends StatefulWidget {
  @override
  _BottomNavBaaarState createState() => _BottomNavBaaarState();
}

class _BottomNavBaaarState extends State<BottomNavBaaar> {
  int _currentIndex = 0;

  List<IconData> iconList = [
    LineIcons.home,
    LineIcons.users,
    LineIcons.mapMarked,
    LineIcons.user,
    LineIcons.rocketChat,
  ];
  List<Widget> items = const [
    FeedsPage(),
    GroupsPage(),
    Placesss(),
    MyProfile(),
    ChatPage()
  ];
  final _profilePageScreen = GlobalKey<NavigatorState>();
  final _categoriesScreen = GlobalKey<NavigatorState>();
  final _addNewArticleScreen = GlobalKey<NavigatorState>();
  final _chatPageScreen = GlobalKey<NavigatorState>();
  final _exploreScreen = GlobalKey<NavigatorState>();
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(index, curve: Curves.easeIn, duration: Duration(milliseconds: 250));
  }

  void goToFirstTab() {
    onTabTapped(0);
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();
  }
  PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
    }
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => await _onWillPop(),
      child: Scaffold(
          bottomNavigationBar: _bottomNavigationBar(),
        body: PageView(
          controller: _pageController,
          allowImplicitScrolling: false,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Navigator(
              key: _exploreScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => FeedsPage(),
              ),
            ),
            // (),
            Navigator(
              key: _chatPageScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) =>  GroupsPage(),
              ),
            ),

            Navigator(
              key: _addNewArticleScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => Placesss(),
              ),
            ),
            Navigator(
              key: _categoriesScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) =>  MyProfile(),
              ),
            ),
            Navigator(
              key: _profilePageScreen,
              onGenerateRoute: (route) => MaterialPageRoute(
                settings: route,
                builder: (context) => ChatPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _bottomNavigationBar() {
    ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(25), topLeft: Radius.circular(25)),
    );
    SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
    EdgeInsets padding = const EdgeInsets.all(0);

    SnakeShape snakeShape = SnakeShape.circle;

    bool showSelectedLabels = true;
    bool showUnselectedLabels = true;

    Color selectedColor = kUniversalColor.withOpacity(0.3);

    return SnakeNavigationBar.color(
      behaviour: snakeBarStyle,
      snakeShape: SnakeShape.circle,

      padding: padding,
      shape: bottomBarShape,

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: selectedColor,
      selectedItemColor:
      snakeShape == SnakeShape.circle ? kUniversalColor : Colors.black,
      unselectedItemColor: Colors.blueGrey,
      selectedLabelStyle: const TextStyle(color: kUniversalColor),

      ///configuration for SnakeNavigationBar.gradient
      //snakeViewGradient: selectedGradient,
      //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
      //unselectedItemGradient: unselectedGradient,

      showUnselectedLabels: showUnselectedLabels,
      showSelectedLabels: showSelectedLabels,

      currentIndex: _currentIndex,
      onTap: (index) => setState(() {
        _currentIndex = index;
        print(_currentIndex);
        onTabTapped(index);
      }),
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              iconList[0],
              size: 25,
            ),
            label: 'Feeds'),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[1],
              size: 25,
            ),
            label: 'Groups'),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[2],
              size: 25,
            ),
            label: 'Places'),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[3],
              size: 25,
            ),
            label: 'Profile'),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[4],
              size: 25,
            ),
            label: 'Chat')
      ],
    );
  }
}
