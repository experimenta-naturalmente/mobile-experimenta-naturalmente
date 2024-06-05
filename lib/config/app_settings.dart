class AppSettings {
  AppSettings._privateConstructor();
  static final AppSettings _instance = AppSettings._privateConstructor();
  static AppSettings get instance => _instance;

  final String googleMapsApiKey =
      const String.fromEnvironment('GOOGLE_MAPS_API_KEY');

  final String awsAccessKey = const String.fromEnvironment('AWS_ACCESS');
  final String awsSecretKey = const String.fromEnvironment('AWS_SECRET');
  final String awsRegion = const String.fromEnvironment('AWS_REGION');
  final String awsBucketName = const String.fromEnvironment('AWS_BUCKET_NAME');
  final String awsDestDir = const String.fromEnvironment('AWS_DEST_DIR');
}
