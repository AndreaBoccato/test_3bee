import 'package:get_it/get_it.dart';
import 'package:test_3bee/core/local_cache.dart';
import 'package:test_3bee/services/apiary_service.dart';
import 'package:test_3bee/services/auth_service.dart';

AuthService get authService => GetIt.instance<AuthService>();

ApiaryService get apiaryService => GetIt.instance<ApiaryService>();

LocalCache get localCache => GetIt.instance<LocalCache>();
