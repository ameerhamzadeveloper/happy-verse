import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hapiverse/data/model/map_model.dart';
import 'package:hapiverse/utils/constants.dart';

class PlacesCard extends StatefulWidget {

  final Results nearBySearch;

  const PlacesCard({Key? key, required this.nearBySearch}) : super(key: key);

  @override
  _PlacesCardState createState() => _PlacesCardState();
}

class _PlacesCardState extends State<PlacesCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.network(
                  "https://source.unsplash.com/user/c_v_r/320x480",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                ),
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
                          /*
                          RatingBar.builder(
                            itemSize: 20,
                            initialRating: double.parse(widget.nearBySearch.rating!),
                            minRating: .5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),

                           */
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
                          Text("2.2 km",
                              style: GoogleFonts.lato(
                                  color: kTextGrey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                          SizedBox(width: 10,),
                          Text("• Open now till 10 pm",
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
                      SizedBox(height: 10,),
                      Container(
                          child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20)),
                              child: Container(
                                color: Colors.yellow.shade500,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(height: 20, width: 10,),
                                    Text("${widget.nearBySearch.userRatingsTotal!}",
                                      style: GoogleFonts.lato(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    Icon(Icons.arrow_drop_down, color: Colors.white,),
                                    SizedBox(height: 10,)
                                  ],
                                ),
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
