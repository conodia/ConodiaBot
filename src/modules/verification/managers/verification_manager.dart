import 'dart:convert';
import 'package:http/http.dart';
import 'package:mineral/core/api.dart';
import 'package:mineral/core/extras.dart';
import 'package:mineral/framework.dart';

import '../../../managers/api/api_http_service.dart';
import '../entities/verification.dart';

class VerificationManager with  Container {
  User user;

  VerificationManager({ required this.user});

  Future<Verification> verifyUser() async {
    Response response = await container.use<PandaApiHttpService>().post(url: '/link/create').payload({"discordUserId": this.user.id, "discordUsername": this.user.tag}).build();
    Map<String, dynamic> body = jsonDecode(response.body);

    return Verification(this.user.id, body.get("verification")['code']);
  }

  Future<bool> isLink() async {
    Response response = await container.use<PandaApiHttpService>().get(url: '/link/islink/${this.user.id}').build();

    dynamic body = jsonDecode(response.body);

    return body['linked'];
  }

  Future<void> unlink() async {
    await container.use<PandaApiHttpService>().destroy(url: '/link/unlink/${this.user.id}').payload({}).build();
  }
}
