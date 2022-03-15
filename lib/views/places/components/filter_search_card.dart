import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapiverse/views/places/components/slider_widget.dart';
import '../../../logic/places/places_cubit.dart';
import '../../../utils/constants.dart';

class FilterSearchCard extends StatefulWidget {

  @override
  _FilterSearchCardState createState() => _FilterSearchCardState();
}

class _FilterSearchCardState extends State<FilterSearchCard> {

  // sort by
  bool isRatingSelected = false;
  bool isDistanceSelected = false;
  bool isRiskSelected = false;

  // rating
  bool isRatingThreeSelected = false;
  bool isRatingThreePointFiveSelected = false;
  bool isRatingFourSelected = false;
  bool isRatingFourPointFiveSelected = false;
  bool isRatingFiveSelected = false;

  // clear all and view results
  bool isClearAllSelected = false;
  bool isViewResultsSelected = false;

  double _valueDistance = 0.0;
  double _valueCovidRiskScore = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Center(child: Text("Sort By",
                style: GoogleFonts.lato(
                    color:  kUniversalColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16))),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: isRatingSelected? kSecendoryColor : Colors.white,
                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                        ),
                        side: const BorderSide(width: 2.0, color: kSecendoryColor,
                        )),
                    onPressed: (){
                      print("rating selected");
                      setState(() {
                        isRiskSelected = false;
                        // isDistanceSelected = false;
                        isRatingSelected = true;

                        // reset rating
                        isRatingThreeSelected = false;
                        isRatingThreePointFiveSelected = false;
                        isRatingFourSelected = false;
                        isRatingFourPointFiveSelected = false;
                        isRatingFiveSelected = false;
                      });
                    }, child: Text("Rating",
                  style: GoogleFonts.lato(
                      color:  isRatingSelected? Colors.white : kSecendoryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                )),
                OutlinedButton(
                  // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                    style: OutlinedButton.styleFrom(
                        backgroundColor: isDistanceSelected? kSecendoryColor : Colors.white,
                        shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                        ),
                        side: const BorderSide(width: 2.0, color: kSecendoryColor,
                        )),
                    onPressed: (){
                      setState(() {
                        // isRatingSelected = false;
                        isRiskSelected = false;
                        isDistanceSelected = true;
                      });
                    }, child: Text("Distance",
                  style: GoogleFonts.lato(
                      color: isDistanceSelected? Colors.white : kSecendoryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16),
                )),
              ],
            ),
            Divider(thickness: 1,color: Colors.grey.withOpacity(.4),),
            SizedBox(height: 10,),
            Center(child: Text("Rating",
                style: GoogleFonts.lato(
                    color:  kUniversalColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16))),
            SizedBox(height: 10,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                      style: OutlinedButton.styleFrom(fixedSize: Size(1, 0),
                          backgroundColor: isRatingThreeSelected? kSecendoryColor : Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                          ),
                          side: const BorderSide(width: 2.0, color: kSecendoryColor,
                          )),
                      onPressed: (){
                        if(isRatingSelected) {
                          BlocProvider.of<PlacesCubit>(context).setRatingDistanceFromFilterSearch(rating: 3);
                          setState(() {
                            isRatingThreeSelected = true;
                            isRatingThreePointFiveSelected = false;
                            isRatingFourSelected = false;
                            isRatingFourPointFiveSelected = false;
                            isRatingFiveSelected = false;
                          });
                        }
                      }, child: Text("3.0",
                    style: GoogleFonts.lato(
                        color:  isRatingThreeSelected? Colors.white : kSecendoryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                        style: OutlinedButton.styleFrom(fixedSize: Size(1, 0),
                            backgroundColor: isRatingThreePointFiveSelected? kSecendoryColor : Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                            ),
                            side: const BorderSide(width: 2.0, color: kSecendoryColor,
                            )),
                        onPressed: (){
                          if(isRatingSelected) {
                            BlocProvider.of<PlacesCubit>(context).setRatingDistanceFromFilterSearch(rating: 3.5);
                            setState(() {
                              isRatingThreeSelected = false;
                              isRatingThreePointFiveSelected = true;
                              isRatingFourSelected = false;
                              isRatingFourPointFiveSelected = false;
                              isRatingFiveSelected = false;
                            });
                          }
                        }, child: Text("3.5",
                      style: GoogleFonts.lato(
                          color: isRatingThreePointFiveSelected? Colors.white : kSecendoryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )),
                  ),
                  OutlinedButton(
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                      style: OutlinedButton.styleFrom(fixedSize: Size(1, 0),
                          backgroundColor: isRatingFourSelected? kSecendoryColor : Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                          ),
                          side: const BorderSide(width: 2.0, color: kSecendoryColor,
                          )),
                      onPressed: (){
                        if(isRatingSelected) {
                          BlocProvider.of<PlacesCubit>(context).setRatingDistanceFromFilterSearch(rating: 4);
                          setState(() {
                            isRatingThreeSelected = false;
                            isRatingThreePointFiveSelected = false;
                            isRatingFourSelected = true;
                            isRatingFourPointFiveSelected = false;
                            isRatingFiveSelected = false;
                          });
                        }
                      }, child: Text("4.0",
                    style: GoogleFonts.lato(
                        color: isRatingFourSelected? Colors.white : kSecendoryColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                      // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                        style: OutlinedButton.styleFrom(fixedSize: Size(1, 0),
                            backgroundColor: isRatingFiveSelected? kSecendoryColor : Colors.white,
                            shape:  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                            ),
                            side: const BorderSide(width: 2.0, color: kSecendoryColor,
                            )),
                        onPressed: (){
                          if(isRatingSelected) {
                            BlocProvider.of<PlacesCubit>(context).setRatingDistanceFromFilterSearch(rating: 5);
                            setState(() {
                              isRatingThreeSelected = false;
                              isRatingThreePointFiveSelected = false;
                              isRatingFourSelected = false;
                              isRatingFourPointFiveSelected = false;
                              isRatingFiveSelected = true;
                            });
                          }
                        }, child: Text("5.0",
                      style: GoogleFonts.lato(
                          color: isRatingFiveSelected? Colors.white : kSecendoryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    )),
                  ),
                ],
              ),
            ),
            Divider(thickness: 1,color: Colors.grey.withOpacity(.4),),
            SizedBox(height: 10,),
            Center(child: Text("Distance",
                style: GoogleFonts.lato(
                    color:  kUniversalColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 16))),
            SizedBox(height: 10,),
            SliderWidget(min: 0, max: 100,minType: "", maxType: "km",),
            SizedBox(height: 10,),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: isClearAllSelected? kSecendoryColor : Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                          ),
                          side: const BorderSide(width: 2.0, color: kSecendoryColor,
                          )),
                      onPressed: (){
                        setState(() {
                          isClearAllSelected = true;
                          isViewResultsSelected = false;
                        });
                      }, child: Text("Clear all",
                    style: GoogleFonts.lato(
                        color:  isClearAllSelected? Colors.white : kSecendoryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
                  OutlinedButton(
                    // style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white), side: ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: isViewResultsSelected? kSecendoryColor : Colors.white,
                          shape:  RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(width: 2.0, color: kSecendoryColor,)
                          ),
                          side: const BorderSide(width: 2.0, color: kSecendoryColor,
                          )),
                      onPressed: (){
                        setState(() {
                          isClearAllSelected = false;
                          isViewResultsSelected = true;
                        });
                        BlocProvider.of<PlacesCubit>(context).setIsFilterResults(results: true, isRatingSelected: isRatingSelected, isDistanceSelected: isDistanceSelected);
                        Navigator.pop(context);
                      }, child: Text("View Results",
                    style: GoogleFonts.lato(
                        color:  isViewResultsSelected? Colors.white : kSecendoryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}