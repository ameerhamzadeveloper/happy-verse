import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../data/model/map_model.dart';
import '../../data/repository/places_repository.dart';
import '../../views/places/places_details.dart';

part 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit()
      : super(PlacesState(
      ratingSelected: false,
      isSearchingNearBy: false,
      suggestionsList: [],
      defaultSuggestionListText: [
        "Hospitals",
        "Vaccine Location",
        "Test Center",
        "Resturant"
      ],
      defaultSuggestionListIcons: [
        Icons.local_hospital,
        Icons.volunteer_activism,
        Icons.center_focus_strong,
        Icons.restaurant,
      ],
      currentLat: 24.401716,
      currentLng: 67.822508,
      markers: {},
      isMapMoving: false,
      isFilterResultsReturned: false,
      distanceSelected: false,
      nearBySearch: null,
      showSuggestions: false,
      isSearching: false,
      isLoading: false,
      locationDescription: "",
      lat: 0,
      lng: 0,
      placeID: null,
      isNearBySearching: true));

  final repository = PlacesRepository();
  static int distanceSelected = 0;
  static double ratingSelected = 0;

  static final Set<Marker> markers = {};

  // setLatLng({required double lat, required double lng}) {
  //   emit(state.copywith(lat: lat, lng: lng));
  // }

  addMarker(
      {required LatLng position,
        required String id,
        required String placeName,
        required int index,
        required BuildContext context}) {
    print("called add Marker");
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
        markerId: markerId,
        icon: BitmapDescriptor.defaultMarker,
        position: position,
        infoWindow: InfoWindow(title: placeName),
        onTap: () {
          print("you have clicked: $index");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => PlacesDetails(
                    nearBySearch: state.nearBySearch!.results![index], currentLat: state.currentLat, currentLng: state.currentLng,)));
        });
    markers.add(marker);
    emit(state.copywith(markers: markers));
  }

  setCurrentLatLng({required double currentLat, required double currentLng}) {
    emit(state.copywith(currentLat: currentLat, currentLng: currentLng));
  }

  clearMarker() {
    markers.clear();
    emit(state.copywith(markers: markers));
  }

  void filterSearchResults(
      {required String name, required BuildContext context}) async {
    clearMarker();
    emit(state.copywith(isSearching: true));

    int radius = getSelectedDistanceFromFilterSearch();
    radius = (radius * 100);
    double rating = getSelectedRatingFromFilterSearch();

    showSuggestionsOrNot(showSuggestionsOrNot: false);
    await getNearBySearch(
        name: name,
        radius: radius.toString(),
        type: name,
        currentLng: state.currentLng,
        currentLat: state.currentLat);

    if (state.ratingSelected) {
      for (int i = 0; i < state.nearBySearch!.results!.length; i++) {
        print(
            "ratingSelected $i) ${state.nearBySearch!.results![i].rating} > || < $rating");
        if (state.nearBySearch!.results![i].rating is double) {
          if (state.nearBySearch!.results![i].rating == rating) {
            addMarker(
                context: context,
                position: LatLng(
                    state.nearBySearch!.results![i].geometry!.location!.lat!,
                    state.nearBySearch!.results![i].geometry!.location!.lng!),
                id: state.nearBySearch!.results![i].placeId!,
                placeName: state.nearBySearch!.results![i].name!,
                index: i);
          }
        } else if (state.nearBySearch!.results![i].rating is int) {
          if (state.nearBySearch!.results![i].rating == rating) {
            addMarker(
                context: context,
                position: LatLng(
                    state.nearBySearch!.results![i].geometry!.location!.lat!,
                    state.nearBySearch!.results![i].geometry!.location!.lng!),
                id: state.nearBySearch!.results![i].placeId!,
                placeName: state.nearBySearch!.results![i].name!,
                index: i);
          }
        }
      }
    } else {
      for (int i = 0; i < state.nearBySearch!.results!.length; i++) {
        print(
            "$i) ${state.nearBySearch!.results![i].geometry!.location!.lat!}");
        addMarker(
            context: context,
            position: LatLng(
                state.nearBySearch!.results![i].geometry!.location!.lat!,
                state.nearBySearch!.results![i].geometry!.location!.lng!),
            id: state.nearBySearch!.results![i].placeId!,
            placeName: state.nearBySearch!.results![i].name!,
            index: i);
      }
    }
  }

  setSelectedDistanceFromFilterSearch({required int distance}) {
    distanceSelected = distance;
    print("setSelectedDistanceFromFilterSearch: $distanceSelected");
  }

  setRatingDistanceFromFilterSearch({required double rating}) {
    ratingSelected = rating;
    print("setRatingDistanceFromFilterSearch: $ratingSelected");
  }

  int getSelectedDistanceFromFilterSearch() {
    print("getSelectedDistanceFromFilterSearch: $distanceSelected");
    return distanceSelected;
  }

  double getSelectedRatingFromFilterSearch() {
    print("getSelectedRatingFromFilterSearch: $ratingSelected");
    return ratingSelected;
  }

  setIsFilterResults(
      {required bool results,
        required isDistanceSelected,
        required bool isRatingSelected}) async {
    Future.delayed(const Duration(microseconds: 300));
    emit(state.copywith(
        isFilterResultsReturned: results,
        distanceSelected: isDistanceSelected,
        ratingSelected: isRatingSelected));
  }

  setUserSearching({required bool isSearching}) {
    emit(state.copywith(isSearching: isSearching));
  }

  setIsMapMoving({required bool isMoving}) {
    emit(state.copywith(isMapMoving: isMoving));
  }

  getSuggestions(
      {required String searchInput,
        required String lang,
        required double currentLat,
        required double currentLng,
        required String type}) async {
    List<Suggestion> suggestionList = await repository.searchSuggestionMap(
        searchInput: searchInput,
        type: type,
        lang: lang,
        currentLat: currentLat,
        currentLng: currentLng);
    emit(state.copywith(suggestionsList: suggestionList));
  }

  showSuggestionsOrNot({required bool showSuggestionsOrNot}) {
    emit(state.copywith(showSuggestions: showSuggestionsOrNot));
  }

  Future<NearBySearch?> getNearBySearch(
      {required String name,
        required String radius,
        required double currentLat,
        required double currentLng,
        required String type}) async {
    NearBySearch? nearBySearch;
    await repository
        .getNearBySearchResults(
        name: name,
        radius: radius,
        type: type,
        currentLat: currentLat,
        currentLng: currentLng)
        .then((value) {
      print("NearBySearch: ${value}");
      emit(state.copywith(nearBySearch: value, isNearBySearching: false));
      nearBySearch = value;
    });
    return nearBySearch;
  }

  Future<bool> getPlaceDetails(
      {required String placeID, required String description}) async {
    Place place = await repository.getPlaceDetailsMap(placeID: placeID);
    print("checkoutCubit: lat: ${place.lat} lng: ${place.lng}");
    emit(state.copywith(
      lng: place.lng,
      lat: place.lat,
      placeID: placeID,
      suggestionsList: [],
      locationDescription: description,
      isLoading: true,
    ));

    return true;
  }

  loadingSuggestions() {
    emit(state.copywith(isLoading: false));
  }

  resetSearch() {
    emit(
        state.copywith(placeID: null, suggestionsList: [], isSearching: false));
  }
}
