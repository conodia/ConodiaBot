import 'package:http/http.dart';
import 'package:mineral/src/internal/services/http_service/http_adapter_contract.dart';

import '../../../utils/debug.dart';

class GetPandaRequestBuilderAdapter extends HttpAdapterContract<GetPandaRequestBuilderAdapter> {
  final dynamic Function(Response response) _responseWrapper;

  GetPandaRequestBuilderAdapter(super._method, super._baseUrl, super._url, super._headers, this._responseWrapper);

  @override
  Future<Response> build () async {
    final response = await get(Uri.parse('$httpBaseUrl$httpUrl'), headers: httpHeaders);
    await Debug().log("GET $httpUrl : ${response.statusCode}");
    return response;
  }
}