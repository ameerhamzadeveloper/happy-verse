import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapiverse/logic/places/places_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/constants.dart';

class PlacesPage extends StatefulWidget {
  const PlacesPage({Key? key}) : super(key: key);

  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  static double currentLat = 0;
  static double currentLng = 0;

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

//it will return distance in KM

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Places"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, locationMap);
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.circular(30),
              ),
              child: BlocBuilder<PlacesCubit, PlacesState>(
                  builder: (context, state) {
                return state.isNearBySearching
                    ? const Center(
                  child: CupertinoActivityIndicator(),
                )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.nearBySearch!.results!.length,
                        itemBuilder: (ctx, index) {
                          // print("photo: ${state.nearBySearch!.results![index].photos![0].photoReference!}");
                          return Padding(
                            padding: const EdgeInsets.only(
                              top:8.0,
                              left:8.0,
                              right:8.0,
                            ),
                            child: Card(
                              child: Container(
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        // Image.network(
                                        //   state.nearBySearch?.results?[index].photos != null ? "https://maps.googleapis.com/maps/api/place/photo?maxwidth=100&photo_reference=${state.nearBySearch?.results?[index].photos?[0].photoReference}&key=AIzaSyAC9Fob5Fk3b_MBXiV4kITtLsI5Qqr1Tv4" : "https://source.unsplash.com/user/c_v_r/320x480",
                                        //   width: 100,
                                        //   height: 100,
                                        //   fit: BoxFit.contain,
                                        // ),
                                        Container(
                                          width: 120,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                    "https://source.unsplash.com/user/c_v_r/320x480",
                                                  ))),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                          state.nearBySearch!
                                              .results![index].name!
                                              .toString().length > 30?
                                                      state.nearBySearch!
                                                          .results![index].name!
                                                          .toString().substring(0,30):state.nearBySearch!
                                              .results![index].name!
                                              .toString(),
                                                      style: GoogleFonts.lato(
                                                          color: kUniversalColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${state.nearBySearch!.results![index].rating!}",
                                                      style: GoogleFonts.lato(
                                                          color:
                                                              kUniversalColor,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13)),
                                                  RatingBarIndicator(
                                                    rating: double.parse(state
                                                        .nearBySearch!
                                                        .results![index]
                                                        .rating!
                                                        .toString()),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 15.0,
                                                    direction:
                                                        Axis.horizontal,
                                                  ),
                                                  Text(
                                                      "(${state.nearBySearch!.results![index].userRatingsTotal!})",
                                                      style: GoogleFonts.lato(
                                                          color: kTextGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13)),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                      "${calculateDistance(currentLat, currentLng, state.nearBySearch!.results![index].geometry!.location!.lat, state.nearBySearch!.results![index].geometry!.location!.lng).roundToDouble()} km",
                                                      style: GoogleFonts.lato(
                                                          color: kTextGrey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 10)),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                      "${state.nearBySearch!.results![index].openingHours != null ? "• Open now" : "• Closed"}",
                                                      style: GoogleFonts.lato(
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12)),
                                                ],
                                              ),
                                              // SizedBox(height: 3,),
                                              Text(
                                                state
                                                            .nearBySearch!
                                                            .results![index]
                                                            .vicinity!
                                                            .toString()
                                                            .length >
                                                        35
                                                    ? "${state.nearBySearch!.results![index].vicinity!.toString().substring(0, 35)}..."
                                                    : state
                                                        .nearBySearch!
                                                        .results![index]
                                                        .vicinity!
                                                        .toString(),
                                                style: GoogleFonts.lato(
                                                    color: kTextGrey,
                                                    fontWeight:
                                                        FontWeight.w400,
                                                    fontSize: 10),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // Container(
                                              //     child: ClipRRect(
                                              //         borderRadius:
                                              //             BorderRadius.only(
                                              //                 bottomLeft: Radius
                                              //                     .circular(
                                              //                         20),
                                              //                 bottomRight:
                                              //                     Radius
                                              //                         .circular(
                                              //                             20),
                                              //                 topLeft: Radius
                                              //                     .circular(
                                              //                         20),
                                              //                 topRight: Radius
                                              //                     .circular(
                                              //                         20)),
                                              //         child: Container(
                                              //           width: 60,
                                              //           color: Colors
                                              //               .yellow.shade500,
                                              //           child: Row(
                                              //             mainAxisAlignment:
                                              //                 MainAxisAlignment
                                              //                     .spaceEvenly,
                                              //             children: [
                                              //               SizedBox(
                                              //                 height: 20,
                                              //                 width: 10,
                                              //               ),
                                              //               Text(
                                              //                 "${state.nearBySearch!.results![index].rating!}",
                                              //                 style: GoogleFonts.lato(
                                              //                     color: Colors
                                              //                         .white,
                                              //                     fontWeight:
                                              //                         FontWeight
                                              //                             .bold,
                                              //                     fontSize:
                                              //                         13),
                                              //               ),
                                              //               Icon(
                                              //                 Icons
                                              //                     .arrow_drop_down,
                                              //                 color: Colors
                                              //                     .white,
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),),),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });

                Container(
                  child: Text(
                      "nearBYSearch: ${state.nearBySearch!.results![19].name}"),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  getNearByPlaces() async {
    // await BlocProvider.of<PlacesCubit>(context).getNearBySearch(name: "restaurant",
    //     type: "restaurant",
    //     currentLat: 24.9630472,
    //     currentLng: 67.1291222);
    await BlocProvider.of<PlacesCubit>(context).getNearBySearch(
        name: "restaurant",
        radius: "1500",
        type: "restaurant",
        currentLat: currentLat,
        currentLng: currentLng);
  }

  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((position) {
      print("01 lat: ${position.latitude}, lng: ${position.longitude}");
      currentLat = position.latitude;
      currentLng = position.longitude;
      // Future.delayed(Duration(seconds: 1));
      getNearByPlaces();
    });
  }
}
