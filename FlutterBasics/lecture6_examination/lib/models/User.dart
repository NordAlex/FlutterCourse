class User {
  User.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      _results = List<_Results>();
      json['results'].forEach((dynamic element) {
        _results.add(_Results.fromJson(element));
      });
    }
  }
  String get name => '${_results.first.name.first} ${_results.first.name.last}';
  Location get location => _results.first.location;
  Picture get picture => _results.first.picture;

  List<_Results> _results;
}

class _Results {
  _Results.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    picture =
        json['picture'] != null ? Picture.fromJson(json['picture']) : null;
  }

  Name name;
  Location location;
  Picture picture;
}

class Name {
  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
  }
  String first;
  String last;
}

class Location {
  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'] != null
        ? Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Coordinates coordinates;
}

class Coordinates {
  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  String latitude;
  String longitude;
}

class Picture {
  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  String large;
  String medium;
  String thumbnail;
}
