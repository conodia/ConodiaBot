import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mineral/src/internal/services/http_service/http_adapter_contract.dart';

import '../../../utils/debug.dart';

class DestroyPandaRequestBuilderAdapter
    extends HttpAdapterContract<DestroyPandaRequestBuilderAdapter> {
  final dynamic Function(Response response) _responseWrapper;

  DestroyPandaRequestBuilderAdapter(super._method, super._baseUrl, super._url,
      super._headers, this._responseWrapper);

  DestroyPandaRequestBuilderAdapter payload(Map<String, dynamic> fields) {
    httpPayload = fields;
    return this;
  }

  @override
  Future<Response> build() async {
    if (httpPayload == null) {
      httpPayload = {};
    }

    final response = await delete(Uri.parse('$httpBaseUrl$httpUrl'), headers: httpHeaders, body: jsonEncode(httpPayload), encoding: Utf8Codec());
    await Debug().log("DESTROY $httpUrl : ${response.statusCode}");

    if (response.statusCode != 200 && response.statusCode != 305) {
      throw HttpException('${response.statusCode} : ${response.body}');
    }

    return response;

/*
    if (httpPayload != null) {
      request.body = jsonEncode(httpPayload);
    }

    await Debug().log("DELETE $httpUrl : before send");

    StreamedResponse response = await request.send();

    // retry when error
    response.stream.handleError((error) async {
      await Debug().log("DELETE $httpUrl : error send, retrying...");
      response = await request.send();
    });

    await Debug().log("DELETE $httpUrl : after send (${response.statusCode})");

    return _responseWrapper(Response.bytes(await response.stream.toBytes(), response.statusCode));*/
  }
}
