import 'dart:convert';
import 'package:recharge_app/core/errors/exception.dart';
import 'package:meta/meta.dart';
import 'package:recharge_app/features/login/data/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_CREDENTIALS = 'CACHED_CREDENTIALS';

abstract class LoginLocalDataScource {
  /// Gets the cached [LoginModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<LoginModel> getLastCachedMobileNumberAndToken();

  Future<void> cacheMobileNumberAndToken(LoginModel loginToCache);
}

class LoginLocalDataScourceImpl implements LoginLocalDataScource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataScourceImpl({@required this.sharedPreferences});

  @override
  Future<LoginModel> getLastCachedMobileNumberAndToken() {
    final jsonString = sharedPreferences.getString(CACHED_CREDENTIALS);

    if (jsonString != null) {
      // Future which is immediately completed
      return Future.value(LoginModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMobileNumberAndToken(LoginModel loginModelToCache) {
    return sharedPreferences.setString(
      CACHED_CREDENTIALS,
      json.encode(loginModelToCache.toJson()),
    );
  }
}
