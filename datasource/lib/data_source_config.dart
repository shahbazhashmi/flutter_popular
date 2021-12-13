class DataSourceConfig {
  static initDataSource(String baseUrl) {
    DataSourceConfig.baseUrl = baseUrl;
  }

  static late String baseUrl;
}
