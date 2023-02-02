import 'package:get_it/get_it.dart';
import 'package:test_3bee/core/local_cache.dart';
import 'package:test_3bee/services/common_service.dart';

CommonService get commonService => GetIt.instance<CommonService>();

LocalCache get localCache => GetIt.instance<LocalCache>();
