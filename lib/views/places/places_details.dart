import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapiverse/views/components/secondry_button.dart';

import '../../data/model/map_model.dart';
import '../../utils/constants.dart';

class PlacesDetails extends StatefulWidget {

  final Results nearBySearch;
  final double currentLat;
  final double currentLng;

  PlacesDetails({Key? key, required this.nearBySearch, required this.currentLat, required this.currentLng}) : super(key: key);

  @override
  _PlacesDetailsState createState() => _PlacesDetailsState();
}

class _PlacesDetailsState extends State<PlacesDetails> {

  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  } //it will return distance in KM

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Place Details"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            "https://source.unsplash.com/user/c_v_r/320x480",
            width: getWidth(context),
            height: 300,
            fit: BoxFit.fill,
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Column(
             children: [
               SizedBox(width: 10,),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(widget.nearBySearch.name!.toString(),
                         style: GoogleFonts.lato(
                             color: kUniversalColor,
                             fontWeight: FontWeight.w400,
                             fontSize: 16)),
                     SizedBox(height: 5,),
                     Row(
                       children: [
                         Text("${widget.nearBySearch.rating!}",
                             style: GoogleFonts.lato(
                                 color: kUniversalColor,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 16)),
                         RatingBarIndicator(
                           rating: double.parse(widget.nearBySearch.rating!.toString()),
                           itemBuilder: (context, index) => Icon(
                             Icons.star,
                             color: Colors.amber,
                           ),
                           itemCount: 5,
                           itemSize: 15.0,
                           direction: Axis.horizontal,
                         ),
                         Text("(${widget.nearBySearch.userRatingsTotal!})",
                             style: GoogleFonts.lato(
                                 color: kTextGrey,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 16)),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Row(
                       children: [
                         Text("${calculateDistance(widget.currentLat, widget.currentLng, widget.nearBySearch.geometry!.location!.lat, widget.nearBySearch.geometry!.location!.lng).roundToDouble()} km",
                             style: GoogleFonts.lato(
                                 color: kTextGrey,
                                 fontWeight: FontWeight.w400,
                                 fontSize: 14)),
                         SizedBox(width: 10,),
                         Text("${widget.nearBySearch.openingHours != null? "• Open now" : "• Closed"}",
                             style: GoogleFonts.lato(
                                 color: Colors.black,
                                 fontWeight: FontWeight.bold,
                                 fontSize: 14)),
                       ],
                     ),
                     SizedBox(height: 10,),
                     Text(widget.nearBySearch.vicinity!.toString(),
                       style: GoogleFonts.lato(
                           color: kTextGrey,
                           fontWeight: FontWeight.w400,
                           fontSize: 14),
                       overflow: TextOverflow.ellipsis,),
                   ],
                 ),
               ),
             ],
           ),
         )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SecendoryButton(
          text: "Add to Favourites",
          onPressed: (){},
        ),
      ),
    );
  }
}
