import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';

class GroupsWidget extends StatelessWidget {
  const GroupsWidget(
      {Key? key,
      required this.groupCover,
      required this.groupName,
      required this.membersCount,
      required this.privacy})
      : super(key: key);
  final String groupName;
  final String privacy;
  final String groupCover;
  final String membersCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getHeight(context) / 4,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(groupCover))),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: kUniversalColor,
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 4, bottom: 4),
                  child: Text(
                    privacy,
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  groupName,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Divider(
                  color: Colors.white,
                ),
                Row(
                  children: [
                    const Icon(
                      LineIcons.users,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      membersCount,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
