import 'package:byte_super_app/app/core/rest/custom_dio.dart';
import 'package:get/get.dart';

import '../database/sqlite_connection_factory.dart';
import '../database/sqlite_migration_factory.dart';

class ApplicationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CustomDio(''), fenix: true);
    // Get.lazyPut(() => CarrinhoService());
    Get.lazyPut(() => SqliteConnectionFactory(), fenix: true);
    Get.lazyPut(() => SqliteMigrationFactory());
  }
}
