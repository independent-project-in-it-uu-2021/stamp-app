import 'package:get_it/get_it.dart';
import 'package:stamp_app/services/storage.dart';
import 'package:stamp_app/services/database.dart';

final locator = GetIt.instance;

void locatorSetUpServices() {
  locator.registerSingleton<StorageServices>(StorageServices());
  locator.registerSingleton<DatabaseService>(DatabaseService());
}
