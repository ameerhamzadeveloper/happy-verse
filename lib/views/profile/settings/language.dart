import 'package:flutter/material.dart';
import 'package:hapiverse/main.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../../components/universal_card.dart';
class LanguageSelection extends StatefulWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {

  void changeLanguage(String code) {
    switch(code){
      case 'en':
        final local = Locale('en', 'US');
        MyApp.setLocale(context, local);
        break;
      case 'zh':
        final local = Locale('zh', 'CN');
        MyApp.setLocale(context, local);
        break;
      case 'ar':
        final local = Locale('ar', 'SA');
        MyApp.setLocale(context, local);
        break;
      case 'ur':
        final local = Locale('ur', 'PK');
        MyApp.setLocale(context, local);
        break;
      case 'hi':
        final local = Locale('hi', 'IN');
        MyApp.setLocale(context, local);
        break;
      case 'es':
        final local = Locale('es', 'ES');
        MyApp.setLocale(context, local);
        break;
    }
  }

  List<LanguageClass> languageList = [
    LanguageClass(languageName: "English (US)", langugeSubName: "English (US)",isSelected: true),
    LanguageClass(languageName: "中國人 (Traditional)", langugeSubName: "中國人 Traditional (Hong Kong)",isSelected: false),
    LanguageClass(languageName: "عربي", langugeSubName: "Arabic",isSelected: false),
    LanguageClass(languageName: "اردو", langugeSubName: "Urdu (PK)",isSelected: false),
    LanguageClass(languageName: "हिन्दी", langugeSubName: "Hindi (IND)",isSelected: false),
    LanguageClass(languageName: "Français", langugeSubName: "French",isSelected: false),
  ];

  int? currentLanguage;

  saveLangugae(int index)async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setInt('language', index);
  }

  getSavedLanguages()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    var cLan = pre.getInt('language');
    if(cLan == 0){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[0].isSelected = true;
      });
    }else if(cLan == 1){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[1].isSelected = true;
      });
    }else if(cLan == 2){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[2].isSelected = true;
      });
    }else if(cLan == 3){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[3].isSelected = true;
      });
    }else if(cLan == 4){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[4].isSelected = true;
      });
    }
    else if(cLan == 5){
      setState(() {
        for(var i in languageList){
          i.isSelected = false;
        }
        languageList[5].isSelected = true;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    getSavedLanguages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(getTranslated(context, 'LANGUAGE')!),
      ),
      body:Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(
            child: Card(
              color: Colors.grey[300],
              shape: cardRadius,
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
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

                              },
                              // autofocus: true,
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
                      SizedBox(height: 20,),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: languageList.length,
                          itemBuilder: (ctx,i){
                            return Padding(
                              padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0),
                              child: InkWell(
                                onTap: (){
                                  saveLangugae(i);
                                  setState(() {
                                    for(var i in languageList){
                                      i.isSelected = false;
                                    }
                                    languageList[i].isSelected = true;
                                  });
                                  if(i == 0){
                                    changeLanguage('en');
                                  }else if(i == 1){
                                    changeLanguage('zh');
                                  }else if(i == 2){
                                    changeLanguage('ar');
                                  }else if(i == 3){
                                    changeLanguage('ur');
                                  }else if(i == 4){
                                    changeLanguage('hi');
                                  }else if(i == 5){
                                    changeLanguage('es');
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(languageList[i].languageName,style: TextStyle(fontSize: 16),),
                                        SizedBox(height: 5,),
                                        Text(languageList[i].langugeSubName,style: TextStyle(fontSize: 12,color: Colors.black.withOpacity(0.6)),),
                                        Divider()
                                      ],
                                    ),
                                    languageList[i].isSelected ? Icon(LineIcons.check,size: 20,) :Container()
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      )
                    ],
                  ),
              ),
            ),
          )
        ],
      )
    );
  }
}
class LanguageClass{
  String languageName;
  String langugeSubName;
  bool isSelected;

  LanguageClass({required this.languageName,required this.langugeSubName,required this.isSelected});
}