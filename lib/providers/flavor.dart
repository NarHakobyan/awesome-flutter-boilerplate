import 'package:secure_chat/constants/flavor_mode.dart';

class Flavor {
  final FlavorMode mode;

  Flavor({this.mode});

  bool isDevelopment() => mode == FlavorMode.development;

  bool isProduction() => mode == FlavorMode.production;
}
