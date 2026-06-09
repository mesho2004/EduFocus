import 'package:dio/dio.dart';
import 'package:edufocus/core/network/api_services.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final dio = Dio(BaseOptions(baseUrl: "http://edufocus.us-east-1.elasticbeanstalk.com/"));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  );
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt<Dio>()));
}

