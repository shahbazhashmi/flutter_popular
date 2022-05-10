import 'package:core/log_helper.dart';
import 'package:core/utils/core_utils.dart';
import 'package:datasource/data_source_config.dart';
import 'package:datasource/network/api.dart';
import 'package:datasource/network/api_call_type.dart';

abstract class BaseRepository {
  final _tag = 'BaseRepository';

  final Api _api = Api();

  handleApiError(dynamic apiResponse);

  dynamic getLocalData(dynamic requestModel);

  saveDataLocally(dynamic requestModel, dynamic responseData);

  Future<dynamic> fetchData(bool mustFetch, ApiCallType apiCallType,
      String controllerName, requestModel) async {
    final isInternetConnected = await CoreUtils.isInternetConnected();

    if (mustFetch && !isInternetConnected) {
      mustFetch = false;
    }

    /// /// /// /// /// ////  ///

    if (!mustFetch) {
      final localData = await getLocalData(requestModel);
      if (localData != null) {
        LogHelper.logInfo(_tag, "$controllerName : publishing local data");
        return localData;
      }
    }

    if (!isInternetConnected) {
      throw Exception('internet is not available');
    }

    LogHelper.logInfo(_tag, "$controllerName : publishing server data");
    final apiResponse = await _fetchApiData(apiCallType,
        "${DataSourceConfig.baseUrl}$controllerName", requestModel);
    saveDataLocally(requestModel, apiResponse);
    return apiResponse;
  }

  Future<dynamic> fetchLiveData(ApiCallType apiCallType,
      String controllerName, requestModel) async {
    final isInternetConnected = await CoreUtils.isInternetConnected();

    if (!isInternetConnected) {
      throw Exception('internet is not available');
    }

    LogHelper.logInfo(_tag, "$controllerName : publishing server data");
    return await _fetchApiData(apiCallType,
        "${DataSourceConfig.baseUrl}$controllerName", requestModel);
  }

  Future<dynamic> _fetchApiData(
      ApiCallType apiCallType, String url, requestModel) async {
    var apiResponse = apiCallType == ApiCallType.get
        ? await _api.get(url)
        : await _api.post(url, requestModel);
    handleApiError(apiResponse);
    return apiResponse;
  }
}
