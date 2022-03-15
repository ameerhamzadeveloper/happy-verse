import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';
import '../../../utils/config/assets_config.dart';
class CovidHistory extends StatefulWidget {
  const CovidHistory({Key? key}) : super(key: key);

  @override
  _CovidHistoryState createState() => _CovidHistoryState();
}

class _CovidHistoryState extends State<CovidHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'HISTORY')!),
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Expanded(
            child: Card(
              color: Colors.white.withOpacity(0.8),
              shape: cardRadius,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context, 'COVID_19_HISTORY')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(getTranslated(context, 'PREVENTION')!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.avoidClose,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'AVOID_CLOSE_CONTACT')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.washHand,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'CLEAN_YOUR_HANDS_OFTEN')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(AssetConfig.useMask,height: getWidth(context) / 4,),
                              Text(getTranslated(context, 'WEAR_A_FACEMASK')!,textAlign: TextAlign.center,)
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0,top: 8,bottom: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Victoria Hospital Dubai"),
                                    Text("${getTranslated(context, 'EXPIRE_ON_19_MARCH')!}12 March 2022",style: TextStyle(fontSize: 12,color: Colors.grey),)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.green
                                    ),
                                    child: Center(
                                      child: Text(getTranslated(context, 'NEGATIVE')!,style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Victoria Hospital Dubai"),
                                    Text("Expire On:12 March 2022",style: TextStyle(fontSize: 12,color: Colors.grey),)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.red
                                    ),
                                    child: Center(
                                      child: Text(getTranslated(context, 'POSITIVE')!,style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
