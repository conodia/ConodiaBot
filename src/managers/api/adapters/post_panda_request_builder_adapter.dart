import 'dart:convert';

import 'package:http/http.dart';
import 'package:mineral/core/services/http.dart';
import 'package:mineral/src/internal/services/http_service/http_adapter_contract.dart';

import '../../../utils/debug.dart';

class PostPandaRequestBuilderAdapter
    extends HttpAdapterContract<PostPandaRequestBuilderAdapter> {
  final dynamic Function(Response response) _responseWrapper;

  PostPandaRequestBuilderAdapter(super._method, super._baseUrl, super._url,
      super._headers, this._responseWrapper) {
    httpPayload = {};
  }

  PostPandaRequestBuilderAdapter payload(Map<String, dynamic> fields) {
    httpPayload = fields;
    return this;
  }

  @override
  Future<Response> build() async {
    final request = Request(httpMethod.uid, Uri.parse('$httpBaseUrl$httpUrl'))
      ..headers.addAll(httpHeaders);

    if (httpPayload != null) {
      request.body = jsonEncode(httpPayload);
    }

    StreamedResponse response = await request.send();

    await Debug().log("${httpMethod.uid} $httpUrl (${response.statusCode})");

    return _responseWrapper(Response.bytes(await response.stream.toBytes(), response.statusCode));
  }
}
