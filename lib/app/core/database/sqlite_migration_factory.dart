import 'migrations/migration.dart';
import 'migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigration() => [
        MigrationV1(),
        //MigrationV2(),
        //MigrationV3(),
      ];
  List<Migration> getUpgradeMigration(int oldVersion) {
    var migrations = <Migration>[];
    if (oldVersion == 1) {
      // migrations.add(MigrationV2());
      //migrations.add(MigrationV3());
    }
    //se tiver mais precisa ir adicionando
    // if (oldVersion == 2) {
    //   migrations.add(MigrationV3());
    // }

    return migrations;
  }
}
