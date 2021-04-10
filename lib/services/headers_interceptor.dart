import 'package:http_interceptor/http_interceptor.dart';
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class HeadersInterceptor implements InterceptorContract {
//

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    // data.headers.addAll(StateService().getHttpHeaders());
    data.headers.addAll(_getContentHeaders());
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    return data;
  }

  static Map<String, String> _getContentHeaders() {
    return {
      'Content-type': 'application/json',
    };
  }

//
}
