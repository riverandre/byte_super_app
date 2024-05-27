import 'package:byte_super_app/app/core/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final getStorage = GetStorage();
    //final sp = await SharedPreferences.getInstance();
    final accessToken = getStorage.read(Constants.USER_KEY);
    options.headers['Authorization'] = 'Bearer $accessToken';
    handler.next(options); //ATENÇÃO - OBRIGATÓRIO
  }

  @override
  // ignore: deprecated_member_use
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      Get.offAllNamed('/auth/login');
    } else {
      handler.next(err);
    }
  }
}
