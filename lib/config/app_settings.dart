class AppSettings {
  AppSettings._privateConstructor();
  static final AppSettings _instance = AppSettings._privateConstructor();
  static AppSettings get instance => _instance;

  final String googleMapsApiKey =
      const String.fromEnvironment('GOOGLE_MAPS_API_KEY');
}
