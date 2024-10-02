import 'dart:io';

import 'package:demo1/demo_model.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioService {
  static final Dio _dio = Dio();

  static disableSSLPinning() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      // Don't trust any certificate just because their root cert is trusted.
      final HttpClient client =
          HttpClient(context: SecurityContext(withTrustedRoots: false));
      // You can test the intermediate / root cert here. We just ignore it.
      String iphost = "192.168.2.97:8080";
      client.findProxy = (uri) => "PROXY $iphost;";

      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      return client;
    };
  }

  static Future<DemoResponse> demoAPI() async {
    disableSSLPinning();
    return DemoResponse.fromJson((await _dio
            .get("https://mocki.io/v1/1bb3d527-d157-47d8-8cd6-9cc6f6d177d0"))
        .data as Map<String, dynamic>);
  }
}
