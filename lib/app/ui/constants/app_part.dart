const String icons = 'assets/icons';
const String image = 'assets/image';

class AppPart {
  static final AppIcons icons = AppIcons();
  static final AppImage image = AppImage();
}

class AppIcons {
  final String geo = '$icons/geo.svg';
  final String wind = '$icons/wind.svg';
  final String drop = '$icons/drop.svg';
  final String eye = '$icons/eye.svg';
  final String eyeOff = '$icons/eye-off.svg';
}

class AppImage {
  final String ellipse = '$image/ellipse.png';
  final String sun = '$image/sun.png';
  final String partlyCloudy = '$image/partly_сloudy.png';
  final String cloudy = '$image/cloudy.png';
  final String shower = '$image/shower.png';
  final String rain = '$image/rain.png';
  final String storm = '$image/storm.png';
  final String snow = '$image/snow.png';
}
