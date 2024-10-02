import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    if (Platform.isAndroid) {
      return super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
    }

    return super.createHttpClient(context)
      ..findProxy = (uri) {
        // String? iphost = (AppPreferences.instance.getHostPort());
        String iphost = "192.168.2.97:8080";
        return "PROXY $iphost;";
      }
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
