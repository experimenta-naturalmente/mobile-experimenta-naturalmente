const String apiBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://localhost:8080/',
);

final Uri apiUri = Uri.parse(apiBaseUrl);
