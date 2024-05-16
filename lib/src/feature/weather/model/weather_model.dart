class Location {
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String tzId;
  final int localtimeEpoch;
  final String localtime;

  Location({
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.tzId,
    required this.localtimeEpoch,
    required this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      region: json['region'],
      country: json['country'],
      lat: json['lat'],
      lon: json['lon'],
      tzId: json['tz_id'],
      localtimeEpoch: json['localtime_epoch'],
      localtime: json['localtime'],
    );
  }
}

class Current {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final double tempF;
  final int isDay;
  final Map<String, dynamic> condition;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final double pressureMb;
  final double pressureIn;
  final double precipMm;
  final double precipIn;
  final int humidity;
  final int cloud;
  final double feelslikeC;
  final double feelslikeF;
  final double visKm;
  final double visMiles;
  final double uv;
  final double gustMph;
  final double gustKph;

  Current({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.isDay,
    required this.condition,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.pressureMb,
    required this.pressureIn,
    required this.precipMm,
    required this.precipIn,
    required this.humidity,
    required this.cloud,
    required this.feelslikeC,
    required this.feelslikeF,
    required this.visKm,
    required this.visMiles,
    required this.uv,
    required this.gustMph,
    required this.gustKph,
  });

  factory Current.fromJson(Map<String, dynamic> json) {
    return Current(
      lastUpdatedEpoch: json['last_updated_epoch'],
      lastUpdated: json['last_updated'],
      tempC: json['temp_c'],
      tempF: json['temp_f'],
      isDay: json['is_day'],
      condition: json['condition'],
      windMph: json['wind_mph'],
      windKph: json['wind_kph'],
      windDegree: json['wind_degree'],
      windDir: json['wind_dir'],
      pressureMb: json['pressure_mb'],
      pressureIn: json['pressure_in'],
      precipMm: json['precip_mm'],
      precipIn: json['precip_in'],
      humidity: json['humidity'],
      cloud: json['cloud'],
      feelslikeC: json['feelslike_c'],
      feelslikeF: json['feelslike_f'],
      visKm: json['vis_km'],
      visMiles: json['vis_miles'],
      uv: json['uv'],
      gustMph: json['gust_mph'],
      gustKph: json['gust_kph'],
    );
  }
}

class Weather {
  final Location location;
  final Current current;

  Weather({required this.location, required this.current});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      location: Location.fromJson(json['location']),
      current: Current.fromJson(json['current']),
    );
  }
}
