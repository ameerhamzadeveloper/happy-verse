// To parse this JSON data, do
//
//     final placeNearby = placeNearbyFromJson(jsonString);

import 'dart:convert';

PlaceNearby placeNearbyFromJson(String str) => PlaceNearby.fromJson(json.decode(str));

String placeNearbyToJson(PlaceNearby data) => json.encode(data.toJson());

class PlaceNearby {
  PlaceNearby({
    required this.htmlAttributions,
    required this.nextPageToken,
    required this.results,
    required this.status,
  });

  List<dynamic> htmlAttributions;
  String nextPageToken;
  List<Result> results;
  String status;

  factory PlaceNearby.fromJson(Map<String, dynamic> json) => PlaceNearby(
    htmlAttributions: List<dynamic>.from(json["html_attributions"].map((x) => x)),
    nextPageToken: json["next_page_token"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "html_attributions": List<dynamic>.from(htmlAttributions.map((x) => x)),
    "next_page_token": nextPageToken,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

class Result {
  Result({
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.reference,
    this.scope,
    this.types,
    this.vicinity,
    this.businessStatus,
    this.openingHours,
    this.plusCode,
    this.rating,
    this.userRatingsTotal,
    this.priceLevel,
  });

  Geometry? geometry;
  String? icon;
  IconBackgroundColor? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photo>? photos;
  String? placeId;
  String? reference;
  Scope? scope;
  List<String>? types;
  String? vicinity;
  BusinessStatus? businessStatus;
  OpeningHours? openingHours;
  PlusCode? plusCode;
  double? rating;
  int? userRatingsTotal;
  int? priceLevel;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    iconBackgroundColor: iconBackgroundColorValues.map![json["icon_background_color"]],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    name: json["name"],
    photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    reference: json["reference"],
    scope: scopeValues.map![json["scope"]],
    types: List<String>.from(json["types"].map((x) => x)),
    vicinity: json["vicinity"],
    businessStatus: json["business_status"] == null ? null : businessStatusValues.map![json["business_status"]],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    userRatingsTotal: json["user_ratings_total"] == null ? null : json["user_ratings_total"],
    priceLevel: json["price_level"] == null ? null : json["price_level"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry!.toJson(),
    "icon": icon,
    "icon_background_color": iconBackgroundColorValues.reverse[iconBackgroundColor],
    "icon_mask_base_uri": iconMaskBaseUri,
    "name": name,
    "photos": photos == null ? null : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "place_id": placeId,
    "reference": reference,
    "scope": scopeValues.reverse[scope],
    "types": List<dynamic>.from(types!.map((x) => x)),
    "vicinity": vicinity,
    "business_status": businessStatus == null ? null : businessStatusValues.reverse[businessStatus],
    "opening_hours": openingHours == null ? null : openingHours!.toJson(),
    "plus_code": plusCode == null ? null : plusCode!.toJson(),
    "rating": rating == null ? null : rating,
    "user_ratings_total": userRatingsTotal == null ? null : userRatingsTotal,
    "price_level": priceLevel == null ? null : priceLevel,
  };
}

enum BusinessStatus { OPERATIONAL }

final businessStatusValues = EnumValues({
  "OPERATIONAL": BusinessStatus.OPERATIONAL
});

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
    viewport: Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location!.toJson(),
    "viewport": viewport!.toJson(),
  };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: Location.fromJson(json["northeast"]),
    southwest: Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast!.toJson(),
    "southwest": southwest!.toJson(),
  };
}

enum IconBackgroundColor { THE_7_B9_EB0, THE_4_B96_F3, THE_909_CE1, F88181 }

final iconBackgroundColorValues = EnumValues({
  "#F88181": IconBackgroundColor.F88181,
  "#4B96F3": IconBackgroundColor.THE_4_B96_F3,
  "#7B9EB0": IconBackgroundColor.THE_7_B9_EB0,
  "#909CE1": IconBackgroundColor.THE_909_CE1
});

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool? openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow,
  };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"],
    htmlAttributions: List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"],
    width: json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height,
    "html_attributions": List<dynamic>.from(htmlAttributions!.map((x) => x)),
    "photo_reference": photoReference,
    "width": width,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String? compoundCode;
  String? globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"],
    globalCode: json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode,
    "global_code": globalCode,
  };
}

enum Scope { GOOGLE }

final scopeValues = EnumValues({
  "GOOGLE": Scope.GOOGLE
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
