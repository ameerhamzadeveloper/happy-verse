import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../utils/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRWidget extends StatelessWidget {
  const QRWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var color = Colors.white;
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.deepPurple,
                radius: 35,
                child: Icon(LineIcons.qrcode,size: 40,color: Colors.white,),
              ),
              SizedBox(height: 10,),
              Text(getTranslated(context, 'QR_SCAN')!,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,fontFamily: ''),textAlign: TextAlign.center,),
            ],
          ),
          QrImage(
            data: 'https://qrco.de/bcr6ox',
            version: QrVersions.auto,
            size: 320,
            // gapless: false,
            // embeddedImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size(80, 80),
            ),
          ),
          // Card(
          //   color: color,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.network("https://www.qr-code-generator.com/wp-content/themes/qr/new_structure/markets/core_market_full/generator/dist/generator/assets/images/websiteQRCode_noFrame.png",height: 200,),
          //   )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color
                ),
                child: Center(
                  child: Column(
                    children: [
                      Icon(LineIcons.shareSquare),
                      Text(getTranslated(context, 'SHARE')!)
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10,),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: color
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(LineIcons.download),
                        Text(getTranslated(context, 'SAVE')!)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(getTranslated(context, 'COVID_19_STATUS')!,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text(getTranslated(context, 'NEGATIVE')!,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
              SizedBox(height: 5,),
              Text("${getTranslated(context, 'EXPIRE_ON_19_MARCH')!} 19 March 2022"),
            ],
          ),
          MaterialButton(
            minWidth: 200,
            shape: StadiumBorder(),
            onPressed: ()=> Navigator.pushNamed(context, viewCovidHistory),
            color: kSecendoryColor,
            child: Text(getTranslated(context, 'VIEW_HISTORY')!,style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  },
);
  }
}
