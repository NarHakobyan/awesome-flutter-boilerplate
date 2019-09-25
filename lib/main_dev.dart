import 'constants/flavor_mode.dart';
import 'main.dart' as app;

Future<void> main() async {
  await app.run(flavor: FlavorMode.development);
}
