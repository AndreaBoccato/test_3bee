import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  static const _accessToken = 'accessToken';
  static const _refreshToken = 'refreshToken';

  final SharedPreferences preferences;

  const LocalCache({
    required this.preferences,
  });

  Future setAccessToken(String accessToken) async {
    await preferences.setString(_accessToken, accessToken);
  }

  String? getAccessToken() {
    return preferences.getString(_accessToken);
  }

  Future setRefreshToken(String refreshToken) async {
    await preferences.setString(_refreshToken, refreshToken);
  }

  String? getRefreshToken() {
    return preferences.getString(_refreshToken);
  }
}
