import 'dart:convert';

import 'package:http/http.dart';
import 'package:mineral/core/extras.dart';

import '../../panda/panda_constants.dart';
import 'api_http_service.dart';

class Api with Container, Environment {
  Future<dynamic> init() async {
    final PandaApiHttpService apiHttpService = PandaApiHttpService(PandaConstant.baseApi);
    apiHttpService.defineHeader(header: 'Content-Type', value: "application/json");
    apiHttpService.defineHeader(header: "Accept", value: "application/json");
    apiHttpService.defineHeader(header: 'Connection', value: "Keep-Alive");
    apiHttpService.defineHeader(header: 'Keep-Alive', value: "timeout=5, max=1000");

    Response response = await apiHttpService.post(url: "/auth").payload({
        "type": "discord",
        "appId": environment.getOrFail("API_ID"),
        "secret": environment.getOrFail("API_SECRET")
      }).build();

    dynamic payload = jsonDecode(response.body);
    print(payload);
    apiHttpService.defineHeader(header: "Authorization", value: "${payload['token']}");

    container.bind((_) => apiHttpService);

    return payload;
  }
}
