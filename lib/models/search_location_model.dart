class Location {
  final String name;
  final double lat;
  final double lon;

  Location({required this.name, required this.lat, required this.lon});

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['display_name'] ?? '',
      lat: double.tryParse(map['lat'].toString()) ?? 0,
      lon: double.tryParse(map['lon'].toString()) ?? 0,
    );
  }
}