import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:hapiverse/views/groups/add_members.dart';
import 'package:hapiverse/views/groups/group_members.dart';
import 'package:line_icons/line_icons.dart';
class GroupSettings extends StatefulWidget {
  final String id;
  const GroupSettings({Key? key,required this.id}) : super(key: key);

  @override
  _GroupSettingsState createState() => _GroupSettingsState();
}

class _GroupSettingsState extends State<GroupSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            ListTile(
              onTap: ()=> nextScreen(context, AddMembersToGroup(groupId: widget.id)),
              title: Text("Invite Members",style: TextStyle(fontWeight: FontWeight.bold),),
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                  child: Icon(Icons.add)),
              subtitle: Text("Add invites new members to group"),
            ),
            ListTile(
              onTap: ()=> nextScreen(context, GroupMembers(id: widget.id)),
              title: Text("Group Members",style: TextStyle(fontWeight: FontWeight.bold),),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(LineIcons.users)),
              subtitle: Text("See all group members"),
            ),
            ListTile(
              onTap: (){},
              title: Text("Leave Group",style: TextStyle(fontWeight: FontWeight.bold),),
              leading: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.exit_to_app)),
              subtitle: Text("Exit to group"),
            )
          ],
        ),
      ),
    );
  }
}
