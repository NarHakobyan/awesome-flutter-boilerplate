import 'package:secure_chat/constants/flavor_mode.dart';

class FlavorService {
  final FlavorMode mode;

  FlavorService({this.mode});

  bool isDevelopment() => mode == FlavorMode.development;

  bool isProduction() => mode == FlavorMode.production;
}
