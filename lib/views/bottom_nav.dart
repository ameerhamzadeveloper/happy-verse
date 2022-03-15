import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/chat/chat_page.dart';
import 'package:hapiverse/views/feeds/feeds.dart';
import 'package:hapiverse/views/groups/groups.dart';
import 'package:hapiverse/views/places.dart';
import 'package:hapiverse/views/places/places.dart';
import 'package:hapiverse/views/profile/my_profile.dart';
import 'package:line_icons/line_icons.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  List<IconData> iconList = [
    LineIcons.home,
    LineIcons.users,
    LineIcons.mapMarked,
    LineIcons.user,
    LineIcons.rocketChat,
  ];

  @override
  void initState() {
    super.initState();
    final bloc = context.read<RegisterCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final groupBloc = context.read<GroupsCubit>();
    final feedsBloc = context.read<FeedsCubit>();
    FocusManager.instance.primaryFocus?.unfocus();
    feedsBloc.getSharedLanguageCode();
    profileBloc.fetchMyPRofile(bloc.userID!, bloc.accesToken!);
    profileBloc.fetchAllMyPosts( bloc.accesToken!,bloc.userID!,);
    groupBloc.getGroups(bloc.userID!, bloc.accesToken!);
    feedsBloc.fetchFeedsPosts(bloc.userID!, bloc.accesToken!);
    print("Herer==================");
    // bloc.intiShared();
    // bloc.getFromShared();
  }

  List<Widget> items = const [
    FeedsPage(),
    GroupsPage(),
    PlacesPage(),
    MyProfile(),
    ChatPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: items[_currentIndex]
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
      unselectedLabelStyle: TextStyle(fontSize: 10),

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
      }),
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              iconList[0],
              size: 25,
            ),
            label: getTranslated(context, 'FEEDS')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[1],
              size: 25,
            ),
            label: getTranslated(context, 'GROUPS')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[2],
              size: 25,
            ),
            label: getTranslated(context, 'PLACES')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[3],
              size: 25,
            ),
            label: getTranslated(context, 'PROFILE')!),
        BottomNavigationBarItem(
            icon: Icon(
              iconList[4],
              size: 25,
            ),
            label: getTranslated(context, 'CHAT')!)
      ],
    );
  }
}
