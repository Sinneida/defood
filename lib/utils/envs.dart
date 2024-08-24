import 'package:envied/envied.dart';

part 'envs.g.dart';

@Envied()
final class Env {
  @EnviedField(varName: 'REPO_URL')
  static const String repoUrl = _Env.repoUrl;

  @EnviedField(varName: 'UPDATE_URL')
  static const String updateUrl = _Env.updateUrl;

  @EnviedField(varName: 'API_URL', obfuscate: true)
  static final String apiUrl = _Env.apiUrl;

  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}
