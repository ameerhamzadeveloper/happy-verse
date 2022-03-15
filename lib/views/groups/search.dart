import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:hapiverse/views/groups/view_group.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import 'components/groups_widget.dart';
class GroupSearch extends StatefulWidget {
  const GroupSearch({Key? key}) : super(key: key);

  @override
  _GroupSearchState createState() => _GroupSearchState();
}

class _GroupSearchState extends State<GroupSearch> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context,state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: const BackButton(color: Colors.black,),
            elevation: 0.0,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200]
                        // border: Border.all()
                      ),
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: TextField(
                          onChanged: (val){
                            context.read<GroupsCubit>().searchGroup(val);
                          },
                          autofocus: true,
                          decoration: InputDecoration(
                              hintText: getTranslated(context, 'SEARCH')!,
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search,size: 20,),
                                onPressed: (){},
                              )
                          ),
                        ),
                      )),
                  SizedBox(height: 10,),
                  // state.searchGroups!.isEmpty ?
                  // Container(
                  //   child: state.isGroupLoading ? Center(child: CupertinoActivityIndicator(),): state.groups!.isEmpty ? Center(child: Text("No Groups"),):ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: state.groups!.length,
                  //     itemBuilder: (ctx,i){
                  //       return InkWell(
                  //         onTap: (){
                  //           // Navigator.pushNamed(context, viewGroups);
                  //           Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGroups(index: i,)));
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(bottom: 8.0),
                  //           child: GroupsWidget(
                  //             groupCover: "${Utils.baseImageUrl}${state.groups![i].groupImageUrl}",
                  //             groupName: state.groups![i].groupName,
                  //             membersCount: "0",
                  //             privacy: state.groups![i].groupPrivacy,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ):
                  Container(
                    child: state.isGroupLoading ? Center(child: CupertinoActivityIndicator(),): state.groups!.isEmpty ? Center(child: Text(getTranslated(context, 'NO_GROUP')!),):ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.searchGroups!.length,
                      itemBuilder: (ctx,i){
                        return InkWell(
                          onTap: (){
                            // Navigator.pushNamed(context, viewGroups);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGroups(index: i,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GroupsWidget(
                              groupCover: "${Utils.baseImageUrl}${state.searchGroups![i].groupImageUrl}",
                              groupName: state.searchGroups![i].groupName,
                              membersCount: "0",
                              privacy: state.searchGroups![i].groupPrivacy,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
