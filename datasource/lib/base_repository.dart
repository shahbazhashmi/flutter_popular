import 'package:datasource/data_source_config.dart';
import 'package:datasource/network/api.dart';
import 'package:datasource/network/api_call_type.dart';

abstract class BaseRepository {
  final Api _api = Api();

  handleApiError(dynamic apiResponse);

  Future<dynamic> fetchData(ApiCallType apiCallType, String controllerName, requestModel) async {
    return await _fetchApiData(apiCallType, "${DataSourceConfig.baseUrl}$controllerName", requestModel);
  }

  Future<dynamic> _fetchApiData(ApiCallType apiCallType, String url, requestModel) async {
    var apiResponse = apiCallType == ApiCallType.get ? await _api.get(url) : await _api.post(url, requestModel);
    handleApiError(apiResponse);
    return apiResponse;
  }
}
