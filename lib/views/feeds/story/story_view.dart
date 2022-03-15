import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/data/model/story_model.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/views/feeds/story/story_widget.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryViewPage extends StatefulWidget {

  StoryViewPage({Key? key}) : super(key: key);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  void onStatusFinished(int index) {
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedsCubit, FeedsState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView.builder(
            controller: pageController,
            clipBehavior: Clip.antiAlias,
            itemCount: state.storyList!.length,
            itemBuilder: (ctx, i) {
              print("Story Item ${state.storyList![i].storyItem.length}");
              return StoryWidgetPage(
                title: state.storyList![i].title,
                image: state.storyList![i].profileImage,
                date: state.storyList![i].date,
                storyItem: state.storyList![i].storyItem,
                controller: state.storyList![i].controller,
                onFinish: () {
                  onStatusFinished(i++);
                },
              );
            },
          ),
        );
      },
    );
  }

}
