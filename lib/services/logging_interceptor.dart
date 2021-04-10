
import 'package:http_interceptor/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

import 'app_configuration.dart';
import 'logger.dart';

class LoggingInterceptor implements InterceptorContract {
//

  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    if (!AppConfiguration.isHttpLoggerEnabled) return data;
    Logger.log("""
==> HTTP-Request
    URL: ${data.url}
    Method: ${data.method}
    Params: ${data.params}
    Base-Url: ${data.baseUrl}
    Headers: ${data.headers}
    Body: ${data.body}
    Runtime-Type: ${data.runtimeType}
""");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    if (!AppConfiguration.isHttpLoggerEnabled) return data;
    Logger.log("""
<== HTTP Response
    URL: ${data.url}
    Method: ${data.method}
    Status-Code: ${data.statusCode}
    Is-Redirect: ${data.isRedirect}
    Persistent-Connection: ${data.persistentConnection}
    Headers: ${data.headers}
    Content-Length: ${data.contentLength}
    Body: ${data.body}
    Runtime-Type: ${data.runtimeType}
""");
    return data;
  }

//
}