part of 'places_cubit.dart';

class PlacesState {
  List<Suggestion> suggestionsList;
  String locationDescription;
  NearBySearch? nearBySearch;
  double lat;
  double lng;
  double currentLat;
  double currentLng;
  String? placeID;
  bool isLoading;
  List<String> defaultSuggestionListText;
  List<Object> defaultSuggestionListIcons;
  bool isSearching;
  bool isSearchingNearBy;
  bool showSuggestions;
  bool isNearBySearching;
  bool distanceSelected;
  bool isMapMoving;
  bool ratingSelected;
  bool isFilterResultsReturned;
  Set<Marker> markers;

  PlacesState(
      {required this.suggestionsList,
        required this.isSearchingNearBy,
        required this.locationDescription,
        required this.ratingSelected,
        required this.currentLat,
        required this.currentLng,
        required this.markers,
        required this.isMapMoving,
        required this.defaultSuggestionListText,
        required this.defaultSuggestionListIcons,
        required this.nearBySearch,
        required this.isFilterResultsReturned,
        required this.showSuggestions,
        required this.distanceSelected,
        required this.lat,
        required this.lng,
        required this.placeID,
        required this.isLoading,
        required this.isSearching,
        required this.isNearBySearching
      });

  PlacesState copywith(
      {List<Suggestion>? suggestionsList,
        String? locationDescription,
        bool? isSearchingNearBy,
        List<String>? defaultSuggestionList,
        List<Object>? defaultSuggestionListIcons,
        NearBySearch? nearBySearch,
        Set<Marker>? markers,
        double? currentLat,
        double? currentLng,
        bool? isMapMoving,
        bool? ratingSelected,
        bool? showSuggestions,
        bool? distanceSelected,
        bool? isFilterResultsReturned,
        double? lat,
        double? lng,
        String? placeID,
        bool? isLoading,
        bool? isSearching,
        bool? isNearBySearching}) {
    return PlacesState(
        suggestionsList: suggestionsList ?? this.suggestionsList,
        locationDescription: locationDescription ?? this.locationDescription,
        defaultSuggestionListText: defaultSuggestionList ?? this.defaultSuggestionListText,
        defaultSuggestionListIcons: defaultSuggestionListIcons ?? this.defaultSuggestionListIcons,
        nearBySearch: nearBySearch ?? this.nearBySearch,
        markers: markers ?? this.markers,
        isSearchingNearBy: isSearchingNearBy ?? this.isSearchingNearBy,
        isMapMoving: isMapMoving ?? this.isMapMoving,
        showSuggestions: showSuggestions ?? this.showSuggestions,
        distanceSelected: distanceSelected ?? this.distanceSelected,
        isFilterResultsReturned: isFilterResultsReturned ?? this.isFilterResultsReturned,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        currentLat: currentLat ?? this.currentLat,
        currentLng: currentLng ?? this.currentLng,
        ratingSelected: ratingSelected ?? this.ratingSelected,
        placeID: placeID ?? this.placeID,
        isLoading: isLoading ?? this.isLoading,
        isSearching: isSearching ?? this.isSearching,
        isNearBySearching: isNearBySearching ?? this.isNearBySearching);
  }
}
