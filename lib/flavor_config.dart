class FlavorConfig {
  final String flavor;
  final String apiUrl;
  final String appName;
  final String token;

  // other config values

  static FlavorConfig? _instance;

  FlavorConfig._({
    required this.apiUrl,
    required this.appName,
    required this.flavor,
    required this.token,
  });

  static void initialize({
    required String apiUrl,
    required String appName,
    required String flavor,
    required String token,
  }) {
    _instance = FlavorConfig._(
      apiUrl: apiUrl,
      appName: appName,
      flavor: flavor,
      token: token,
    );
  }

  static FlavorConfig get instance {
    if (_instance == null) {
      throw Exception(
        "FlavorConfig not initialized. Call FlavorConfig.initialize() in your main_<flavor>.dart",
      );
    }
    return _instance!;
  }

  bool get isLocal => flavor.toUpperCase() == "LOCAL";
}
