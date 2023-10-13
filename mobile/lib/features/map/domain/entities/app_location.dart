class AppLocation {
  final double lat;
  final double long;

  const AppLocation({
    required this.lat,
    required this.long,
  });
}

class MoscowLocation extends AppLocation {
  const MoscowLocation({
    super.lat = 55.7522200,
    super.long = 37.6155600,
  });
}