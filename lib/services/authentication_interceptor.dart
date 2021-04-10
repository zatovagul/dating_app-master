import 'package:dating_app/services/hive_helper.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import 'app_endpoints.dart';

class AuthenticationInterceptor implements InterceptorContract {
//

  static final NO_AUTH_ENDPOINTS = [
    AppEndpoints.auth,
    AppEndpoints.registration,
    AppEndpoints.verification,
  ];

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (NO_AUTH_ENDPOINTS.contains(data.url)) {
      return data;
    }
    final String token = HiveHelper.token;
    if (token != null) {
      // data.headers['Authorization'] = 'Bearer ${token}';
      data.headers.addAll({
        'Authorization': 'Bearer $token',
      });
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (data.statusCode == 401) {
      HiveHelper.deleteRefreshToken();
    }
    return data;
  }

//
}
