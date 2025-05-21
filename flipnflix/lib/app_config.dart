class AppConfig {
  static AppConfig get instance {
    if (_instance == null) {
      const apiKey = String.fromEnvironment("api_key");
      const baseUrl = String.fromEnvironment("base_url");
      const token = String.fromEnvironment("token");

      _instance = AppConfig._internal(apiKey, baseUrl, token);

      return _instance!;
    }
    return _instance!;
  }

  static AppConfig? _instance;
  AppConfig._internal(this.apiKey, this.baseUrl, this.token);

  final String apiKey;
  final String baseUrl;
  final String token;
}
