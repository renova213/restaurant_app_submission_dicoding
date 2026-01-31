class AppAssets {
  static const lotties = _AppLottie();
  static const fonts = _AppFont();
  static const images = _AppImage();
  static const icons = _AppIcon();
}

class _AppLottie {
  const _AppLottie();
  final String _path = 'assets/lotties';

  String get emptyData => '$_path/empty_data.json';
}

class _AppImage {
  const _AppImage();
  final String _path = 'assets/images';

  String get logo => '$_path/logo.png';
}

class _AppIcon {
  const _AppIcon();
  final String _path = 'assets/icons';

  String get location => '$_path/location.svg';
}

class _AppFont {
  const _AppFont();

  String get poppins => 'Poppins';
}
