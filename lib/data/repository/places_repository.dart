import 'package:hapiverse/data/model/map_model.dart';
import 'package:hapiverse/data/provider/map_autocomplete_provider.dart';

class PlacesRepository {

  Future<List<Suggestion>> searchSuggestionMap({required String searchInput, required String lang,required double currentLat,required double currentLng, required String type}) async {

    final suggestion = await PlaceApiProvider().fetchSuggestions(input: searchInput, type: type, lang: lang, currentLat: currentLat, currentLng: currentLng);

    return suggestion;
  }

  Future<NearBySearch> getNearBySearchResults({required String name, required String radius, required double currentLat,required double currentLng, required String type}) async {

    final suggestionTest = await PlaceApiProvider().getNearBySearchResults(name: name, radius: radius, type: type, currentLat: currentLat, currentLng: currentLng);

    return suggestionTest;
  }

  Future<Place> getPlaceDetailsMap({required String placeID}) async {

    final Place place = await PlaceApiProvider().getPlaceDetailFromId(placeID);

    return place;
  }
}