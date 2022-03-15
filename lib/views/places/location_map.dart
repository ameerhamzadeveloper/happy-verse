import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';

import '../../data/model/map_model.dart';
import '../../logic/places/places_cubit.dart';
import '../../utils/constants.dart';
import 'components/filter_search_card.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {

  Future filterSearchAlertDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) {
          return FilterSearchCard();
        });
  }

  static late Set<Circle> circles;
  static late double currentLat = 24.401716;
  static late double currentLng = 67.822508;

  final TextEditingController searchController = TextEditingController();

  Completer<GoogleMapController> completer = Completer();

  LatLng initPosition = const LatLng(24.401716, 67.822508);

  onMapCreated(GoogleMapController controller) {
    _controller = controller;
    completer.complete(_controller);
  }

  onCameraMove(CameraPosition position) {
    initPosition = position.target;
  }

  GoogleMapController? _controller;

  void animateCamera(LatLng position) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 13.0,
    )));
  }

  @override
  void initState() {
    BlocProvider.of<PlacesCubit>(context).resetSearch();
    circles = Set.from([
      Circle(
        circleId: CircleId("myCircle"),
        center: _createCenter(),
        radius: 2000,
        fillColor: Colors.blue.shade100.withOpacity(0.5),
        strokeColor: Colors.blue.shade100.withOpacity(0.1),
      )
    ]);
    getCurrentLocation();
    super.initState();
  }

  getCurrentLocation() async {
    await BlocProvider.of<PlacesCubit>(context).clearMarker();
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition().then((position) async {
      currentLat = position.latitude;
      currentLng = position.longitude;
      await BlocProvider.of<PlacesCubit>(context).setCurrentLatLng(currentLat: currentLat, currentLng: currentLng);
      animateCamera(LatLng(position.latitude, position.longitude));
    });
  }

  LatLng _createCenter() {
    return _createLatLng(currentLat , currentLng);
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<PlacesCubit, PlacesState>(builder: (context, state) {

      if(state.isFilterResultsReturned) {
        BlocProvider.of<PlacesCubit>(context).filterSearchResults(context: context ,name: "restaurant");
        BlocProvider.of<PlacesCubit>(context).setIsFilterResults(results: false, isDistanceSelected: state.distanceSelected, isRatingSelected: state.ratingSelected);
      }

      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: Text("Search Places"),
          actions: [
            IconButton(
              onPressed: () async {
                FocusScope.of(context)
                    .requestFocus(FocusNode());
                await Geolocator.requestPermission();
                Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high)
                    .then((position) async {
                  currentLat = position.latitude;
                  currentLng = position.longitude;
                  await BlocProvider.of<PlacesCubit>(context).setCurrentLatLng(currentLat: currentLat, currentLng: currentLng);

                  circles = Set.from([Circle(
                    circleId: CircleId("myCircle"),
                    center: _createCenter(),
                    radius: 2000,
                    fillColor: Colors.blue.shade100.withOpacity(0.5),
                    strokeColor: Colors.blue.shade100.withOpacity(0.1),
                  )
                  ]);
                  animateCamera(LatLng(currentLat, currentLng));
                  print(position);
                });
              },
              icon: const Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    )),
                child: GoogleMap(
                  circles: circles,
                  zoomControlsEnabled: true,
                  initialCameraPosition:
                  CameraPosition(target: initPosition, zoom: 13.0),
                  onMapCreated: onMapCreated,
                  tiltGesturesEnabled: true,
                  onCameraMove: (pos) async {
                    print(
                        "Camerea moving ${pos.target.latitude} ${pos.target.longitude}");
                    BlocProvider.of<PlacesCubit>(context).setIsMapMoving(isMoving: true);
                    currentLat = pos.target.latitude;
                    currentLng = pos.target.longitude;
                    await BlocProvider.of<PlacesCubit>(context).setCurrentLatLng(currentLat: currentLat, currentLng: currentLng);
                  },
                  onCameraIdle: () {
                    print("Ideleee");
                    BlocProvider.of<PlacesCubit>(context).setIsMapMoving(isMoving: false);
                    circles = Set.from([Circle(
                      circleId: CircleId("myCircle"),
                      center: _createCenter(),
                      radius: 2000,
                      fillColor: Colors.blue.shade100.withOpacity(0.5),
                      strokeColor: Colors.blue.shade100.withOpacity(0.1),
                    )
                    ]);
                  },
                  onTap: (lat) {
                    print("Camerea moving ${lat.longitude}");
                  },
                  mapType: MapType.normal,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: state.markers,
                )),
            state.isMapMoving
                ? const Align(
              alignment: Alignment.center,
              child: Icon(LineIcons.mapPin,
                  size: 42.0, color: kUniversalColor),
            )
                : const Align(
              alignment: Alignment.center,
              child: Icon(LineIcons.mapMarker,
                  size: 35.0, color: kUniversalColor),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.only(left:8.0),
                      child: TextField(
                        controller: searchController,
                        onTap: () async {
                          if (searchController.text.isEmpty) {
                            print("searchController.text.isEmpty");
                            await BlocProvider.of<PlacesCubit>(context)
                                .setUserSearching(isSearching: false);
                            await BlocProvider.of<PlacesCubit>(context)
                                .showSuggestionsOrNot(showSuggestionsOrNot: true);
                          } else {
                            print("searchController.text.isNotEmpty");
                          }
                        },
                        onChanged: (val) async {
                          print(
                              "currentLat: $currentLat, currentLng: $currentLng, searchController: ${searchController.text}");

                          if (val.isNotEmpty && val.length >= 2) {
                            final bloc = BlocProvider.of<PlacesCubit>(context);
                            await bloc.setUserSearching(isSearching: true);
                            await BlocProvider.of<PlacesCubit>(context)
                                .showSuggestionsOrNot(showSuggestionsOrNot: false);
                            await bloc.getSuggestions(searchInput: val,
                                type: "",
                                lang: "en",
                                currentLat: currentLat,
                                currentLng: currentLng);
                          } else if (val.isNotEmpty){
                            await BlocProvider.of<PlacesCubit>(context)
                                .setUserSearching(isSearching: false);
                            await BlocProvider.of<PlacesCubit>(context)
                                .showSuggestionsOrNot(showSuggestionsOrNot: true);
                            await BlocProvider.of<PlacesCubit>(context)
                                .getSuggestions(searchInput: val,
                                type: "",
                                lang: "en",
                                currentLat: currentLat,
                                currentLng: currentLng);
                          } else {
                            await BlocProvider.of<PlacesCubit>(context)
                                .setUserSearching(isSearching: false);
                            await BlocProvider.of<PlacesCubit>(context)
                                .showSuggestionsOrNot(showSuggestionsOrNot: false);
                          }
                        },
                        decoration: InputDecoration(
                          // filled: true,
                          // fillColor: Colors.white,
                          suffixIcon: IconButton(
                            onPressed: () async {
                              await filterSearchAlertDialogue(context);
                            },
                            icon: const Icon(
                              Icons.list,
                              color: kSecendoryColor,
                            ),
                          ),
                          hintText: "Address",
                          labelStyle: TextStyle(color: Colors.grey),
                          hintStyle: TextStyle(color: Colors.blue),
                          border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                  state.isSearching
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.suggestionsList.length,
                      itemBuilder: (ctx, index) {
                        print(
                            "resultAfter: lat: ${state.lat} lng: ${state.lng}");
                        return Padding(
                          padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: ListTile(
                                onTap: () async {
                                  final bool result =
                                  await BlocProvider.of<PlacesCubit>(
                                      context)
                                      .getPlaceDetails(
                                      placeID: state
                                          .suggestionsList[index]
                                          .placeId,
                                      description: state
                                          .suggestionsList[index]
                                          .description);
                                  if (result) {
                                    searchController.clear();
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    print(
                                        "result: $result lat: ${state.lat} lng: ${state.lng}");
                                    animateCamera(
                                        LatLng(state.lat, state.lng));
                                  }
                                },
                                title: Text(
                                  (state
                                      .suggestionsList[index].description),
                                )),
                          ),
                        );
                      })
                      : Container(),
                  state.showSuggestions
                      ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.defaultSuggestionListText.length,
                      itemBuilder: (ctx, index) {
                        print(
                            "resultAfter: lat: ${state.lat} lng: ${state.lng}");
                        return Padding(
                          padding: const EdgeInsets.only(top:8.0,left:8.0,right: 8.0),
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Icon(
                                    state.defaultSuggestionListIcons[index]
                                    as IconData,
                                    color: kSecendoryColor,
                                  ),
                                  InkWell(
                                      onTap: () async {
                                        await BlocProvider.of<
                                            PlacesCubit>(context)
                                            .setUserSearching(
                                            isSearching: true);

                                        await BlocProvider.of<
                                            PlacesCubit>(context)
                                            .showSuggestionsOrNot(
                                            showSuggestionsOrNot: false);

                                        await BlocProvider.of<PlacesCubit>(context).clearMarker();
                                        final NearBySearch? nearBySearch = await BlocProvider.of<PlacesCubit>(context).getNearBySearch(name: state.defaultSuggestionListText[index], type: state.defaultSuggestionListText[index], radius: "1500", currentLat: currentLat, currentLng: currentLng);

                                        print("return NearBy: ${nearBySearch!.results![0].name}");
                                        if(nearBySearch != null) {
                                          for (int i = 0; i <
                                              nearBySearch.results!
                                                  .length; i++) {
                                            print("$i) ${nearBySearch
                                                .results![i].geometry!
                                                .location!.lat!}");
                                            BlocProvider.of<PlacesCubit>(
                                                context).addMarker(
                                                context: context,
                                                position: LatLng(
                                                    nearBySearch
                                                        .results![i]
                                                        .geometry!.location!
                                                        .lat!,
                                                    nearBySearch
                                                        .results![i]
                                                        .geometry!.location!
                                                        .lng!),
                                                id: "currentLocation$i",
                                                placeName: nearBySearch
                                                    .results![i].name!,
                                                index: i);
                                          }
                                        }
                                      },
                                      child: Text(
                                        (state.defaultSuggestionListText[
                                        index]),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                      : Container()
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
