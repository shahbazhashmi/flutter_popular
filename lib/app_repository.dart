import 'package:core/custom_exceptions.dart';
import 'package:datasource/base_repository.dart';

class AppRepository extends BaseRepository {
  static const _errorMessage = "errorMessage";

  @override
  handleApiError(apiResponse) {
    if (apiResponse[_errorMessage].toString().isNotEmpty) {
      throw ApiErrorException(apiResponse[_errorMessage]);
    }
  }
}
