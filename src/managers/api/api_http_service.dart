
import 'package:http/http.dart' as http;
import 'package:mineral/core/services/http.dart';
import 'package:mineral/exception.dart';

import 'adapters/destroy_panda_request_builder_adapter.dart';
import 'adapters/get_panda_request_builder_adapter.dart';
import 'adapters/post_panda_request_builder_adapter.dart';

class PandaApiHttpService extends HttpService<GetPandaRequestBuilderAdapter, PostPandaRequestBuilderAdapter, DestroyPandaRequestBuilderAdapter> {
  PandaApiHttpService(super.baseUrl);

  @override
  GetPandaRequestBuilderAdapter get ({ required String url }) =>
      GetPandaRequestBuilderAdapter(HttpMethod.get, baseUrl, url, headers, (http.Response response) => responseWrapper(response));

  @override
  PostPandaRequestBuilderAdapter post ({ required String url }) =>
      PostPandaRequestBuilderAdapter(HttpMethod.post, baseUrl, url, headers, (http.Response response) => responseWrapper(response));

  @override
  PostPandaRequestBuilderAdapter put ({ required String url }) =>
      PostPandaRequestBuilderAdapter(HttpMethod.put, baseUrl, url, headers, (http.Response response) => responseWrapper(response));

  @override
  PostPandaRequestBuilderAdapter patch ({ required String url }) =>
      PostPandaRequestBuilderAdapter(HttpMethod.patch, baseUrl, url, headers, (http.Response response) => responseWrapper(response));

  @override
  DestroyPandaRequestBuilderAdapter destroy ({ required String url }) =>
      DestroyPandaRequestBuilderAdapter(HttpMethod.destroy, baseUrl, url, headers, (http.Response response) => responseWrapper(response));

  http.Response responseWrapper<T> (http.Response response) {
    if (response.statusCode != 200 && response.statusCode != 305) {
      throw HttpException('${response.statusCode} : ${response.body}');
    }

    return response;
  }
}