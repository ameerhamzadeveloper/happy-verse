import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/feeds/voice_to_text.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
import 'other_profile/other_profile_page.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    context.read<FeedsCubit>().assignSearchNull();
  }
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.read<FeedsCubit>().assignSearchNull();
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back,color: Colors.black,)),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: getWidth(context) - 70,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200]
                    // border: Border.all()
                  ),
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: state.searchController,
                    keyboardType: TextInputType.text,
                    onChanged: (val){

                      bloc.assignSearchText(val);
                      bloc.searchUser(authB.userID!, authB.accesToken!);
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search,size: 20,),
                        onPressed: (){},
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceToTextPage())),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(Icons.mic),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 35,
              // decoration: BoxDecoration(
              //   color: Colors.grey[300],
              //   borderRadius: BorderRadius.circular(
              //     25.0,
              //   ),
              // ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: const BoxDecoration(
                  // borderRadius: BorderRadius.circular(
                  //   25.0,
                  // ),
                  border: Border(bottom: BorderSide(color: kUniversalColor)),
                  // color: kUniversalColor,
                ),
                labelColor: kUniversalColor,
                unselectedLabelColor: Colors.black,
                onTap: (i) {
                  setState(() {
                    _tabController.index = i;
                  });
                },
                tabs: const [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Peoples',
                  ),
                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Business',
                  ),
                ],
              ),
            ),
            state.searchedUsersList == null ? Center(child: Text("Search Users"),):
                _tabController.index == 0 ? Expanded(
                  child: state.isSearching ? Center(child: CupertinoActivityIndicator(),):ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx,i){
                      var d = state.searchedUsersList![i];
                      return ListTile(
                        onTap: (){
                          profileBloc.fetchOtherProfile(d.userId!, authB.accesToken!,authB.userID!);
                          profileBloc.fetchOtherAllPost(d.userId!, authB.accesToken!,authB.userID!);
                          nextScreen(context, OtherProfilePage(userId: d.userId!));
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[200],
                          backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.searchedUsersList![i].profileImageUrl}"),
                        ),
                        title: Text(state.searchedUsersList![i].userName!),
                        subtitle: Text(d.country!),
                        trailing: TextButton(
                          onPressed: (){
                            context.read<ProfileCubit>().addFollow(d.userId!, authB.userID!, authB.accesToken!);
                            context.read<FeedsCubit>().searchUser(authB.userID!, authB.accesToken!);
                            print(d.isFriend);
                          },
                          child: Text(d.martialStatus!),
                        ),
                      );
                    },
                    itemCount: state.searchedUsersList!.length,
                  ),
                ):Container(
                  child: Text("Comming Soon"),
                )
          ],
        ),
      ),
    );
  },
);
  }
}
