import "package:http/http.dart" as http;

class Networkhandler {
  static final client = http.Client();
  static void post(var body, String endpoint) async {
    var res = await client.post(buildUrl(endpoint), body: body);
  }

  static Uri buildUrl(String endpoint) {
    String host = "https://k8b207.p.ssafy.io/api";
    final apiPath = host + endpoint;
    return Uri.parse(apiPath);
  }
}
