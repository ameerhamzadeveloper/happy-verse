import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class LoadingPostWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.grey[100];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 4,
      itemBuilder: (ctx,i){
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap:(){

                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: color,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 20,
                                  width: getWidth(context) - 200,
                                  color: color,
                                ),
                                SizedBox(height: 5,),
                                Container(
                                  width: getWidth(context) - 150,
                                  height: 10,
                                  color: color,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: getHeight(context) / 4,
                  decoration: BoxDecoration(
                      color: color
                  ),
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Container(
                        width: getWidth(context) - 200,
                        height: 10,
                        color: color,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: (){},
                                child: CircleAvatar(
                                  backgroundColor: color,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: (){},
                                child: CircleAvatar(
                                  backgroundColor: color,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: color,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
