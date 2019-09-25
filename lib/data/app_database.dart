import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:secure_chat/constants/db_constants.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  // Completer is used for transforming synchronous code into asynchronous code.
  Completer<Database> _dbOpenCompleter;

  // Key for encryption
  String encryptionKey = '';

  // Database object accessor
  Future<Database> getDatabase() async {
    // If completer is null, AppDatabaseClass is newly instantiated, so database is not yet opened
    if (_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer<Database>();

      // Calling _openDatabase will also complete the completer with database instance
      await _openDatabase();
    }
    // If the database is already opened, awaiting the future will happen instantly.
    // Otherwise, awaiting the returned future will take some time - until complete() is called
    // on the Completer in _openDatabase() below.
    return _dbOpenCompleter.future;
  }

  Future<void> _openDatabase() async {
    // Get a platform-specific directory where persistent app data can be stored
    final Directory appDocumentDir = await getApplicationDocumentsDirectory();

    // Path with the form: /platform-specific-directory/demo.db
    final String dbPath = join(appDocumentDir.path, DBConstants.dbName);

    // Check to see if encryption is set, then provide codec
    // else init normal db with path
    Database database;
    if (encryptionKey.isNotEmpty) {
      // Initialize the encryption codec with a user password
      // var codec = getXXTeaCodec(password: encryptionKey);
      database = await databaseFactoryIo.openDatabase(
        dbPath, /*codec: codec*/
      );
    } else {
      database = await databaseFactoryIo.openDatabase(dbPath);
    }

    // Any code awaiting the Completer's future will now start executing
    _dbOpenCompleter.complete(database);
  }
}
