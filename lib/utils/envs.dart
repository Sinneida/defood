import 'package:envied/envied.dart';

part 'envs.g.dart';

@Envied()
final class Env {
  @EnviedField(varName: 'REPO_URL')
  static const String repoUrl = _Env.repoUrl;

  @EnviedField(varName: 'UPDATE_URL')
  static const String updateUrl = _Env.updateUrl;
}
