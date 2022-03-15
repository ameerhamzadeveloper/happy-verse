import 'package:flutter/material.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/views/bottom.dart';
import 'package:hapiverse/views/feeds/post/play_video.dart';
import 'package:hapiverse/views/groups/search.dart';
import 'package:hapiverse/views/profile/edit_profile/edit_profile.dart';
import 'package:hapiverse/views/profile/edit_profile/edit_profile_image.dart';
import 'package:hapiverse/views/profile/settings/data_policy.dart';
import 'package:hapiverse/views/profile/settings/location.dart';
import 'package:hapiverse/views/profile/settings/privacy_policy.dart';
import 'package:hapiverse/views/profile/settings/terms_of_service.dart';
import 'package:hapiverse/views/splash_normal.dart';
import 'package:hapiverse/views/authentication/cat_interest.dart';
import 'package:hapiverse/views/authentication/interest.dart';
import 'package:hapiverse/views/authentication/sign_in.dart';
import 'package:hapiverse/views/authentication/sign_up.dart';
import 'package:hapiverse/views/authentication/sub_cat_interest.dart';
import 'package:hapiverse/views/bottom_nav.dart';
import 'package:hapiverse/views/chat/call_page.dart';
import 'package:hapiverse/views/chat/conservation.dart';
import 'package:hapiverse/views/feeds/other_profile/other_profile_page.dart';
import 'package:hapiverse/views/feeds/post/add_post.dart';
import 'package:hapiverse/views/feeds/feeds.dart';
import 'package:hapiverse/views/loading_page.dart';
import 'package:hapiverse/views/profile/health/add_record_page.dart';
import 'package:hapiverse/views/profile/health/health.dart';
import 'package:hapiverse/views/feeds/notification.dart';
import 'package:hapiverse/views/feeds/search_page.dart';
import 'package:hapiverse/views/feeds/story/add_image.dart';
import 'package:hapiverse/views/feeds/story/add_video_page.dart';
import 'package:hapiverse/views/feeds/story/design_story.dart';
import 'package:hapiverse/views/groups/create_group.dart';
import 'package:hapiverse/views/profile/create_profile.dart';
import 'package:hapiverse/views/profile/health/history.dart';
import 'package:hapiverse/views/profile/settings/language.dart';
import 'package:hapiverse/views/profile/settings/notification.dart';
import 'package:hapiverse/views/profile/settings/personal_account.dart';
import 'package:hapiverse/views/profile/settings/settings.dart';
import 'package:hapiverse/views/splash.dart';
import '../views/not_found.dart';
import '../views/places/location_map.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case signin:
        return MaterialPageRoute(builder: (_) => const SignIn());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case catInterest:
        return MaterialPageRoute(builder: (_) => const CategoryIntrest());
      case interest:
        return MaterialPageRoute(builder: (_) => const InterestPage());
      case feeds:
        return MaterialPageRoute(builder: (_) => const FeedsPage());
      case nav:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case notifications:
        return MaterialPageRoute(builder: (_) => const Notifications());
      case health:
        return MaterialPageRoute(builder: (_) => const HealthPage());
      // case addPost:
      //   return MaterialPageRoute(builder: (_) => const AddPostPage());
      case subCatInterset:
        return MaterialPageRoute(builder: (_) => const InterestSubCat());
      case createProfile:
        return MaterialPageRoute(builder: (_) => const CreateProfile());
      case storyDesign:
        return MaterialPageRoute(builder: (_) => const DesignStory());
      case storyImagePage:
        return MaterialPageRoute(builder: (_) => const AddImagePageStory());
      case storyVideoPage:
        return MaterialPageRoute(builder: (_) => const AddVideoPageStory());
      case searchPage:
        return MaterialPageRoute(builder: (_) => const SearchPage());
      case createGroups:
        return MaterialPageRoute(builder: (_) => const CreateGroups());
      case profileSettings:
        return MaterialPageRoute(builder: (_) => const ProfileSettings());
      case personalAccount:
        return MaterialPageRoute(builder: (_) => const PersonalAccount());
      case notificationSettings:
        return MaterialPageRoute(builder: (_) => const NotificationSetting());
      case languageSelection:
        return MaterialPageRoute(builder: (_) => const LanguageSelection());
      case locationMap:
        return MaterialPageRoute(builder: (_) => const LocationMap());
      case viewCovidHistory:
        return MaterialPageRoute(builder: (_) => const CovidHistory());
      case addRecordPAge:
        return MaterialPageRoute(builder: (_) => const AddRecordPage());
      case callpage:
        return MaterialPageRoute(builder: (_) =>  CallPage());
      case loadingPage:
        return MaterialPageRoute(builder: (_) =>  LoadingPage());
      case splashNormal:
        return MaterialPageRoute(builder: (_) =>  SplashNormalPage());
      case playVidePage:
        return MaterialPageRoute(builder: (_) =>  const PlayVideoPage());
      case editProfile:
        return MaterialPageRoute(builder: (_) =>  const EditProfile());
      case groupSearch:
        return MaterialPageRoute(builder: (_) =>  const GroupSearch());
      case editProfileImage:
        return MaterialPageRoute(builder: (_) =>  const EditProfileImage());
      case locationSettings:
        return MaterialPageRoute(builder: (_) =>  const LocationSettings());
      case bottomNavTemp:
        return MaterialPageRoute(builder: (_) =>  BottomNavBaaar());
      case privacyPolicy:
        return MaterialPageRoute(builder: (_) =>  const PrivacyPolicyPage());
      case termsOfService:
        return MaterialPageRoute(builder: (_) =>  const TermsOfService());
      case dataPolicy:
        return MaterialPageRoute(builder: (_) =>  const DataPolicy());
    }
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
