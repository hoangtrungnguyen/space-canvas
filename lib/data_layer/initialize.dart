import 'package:ideascape/aliases.dart';
import 'package:ideascape/data_layer/repositories/space_dashboard_repository.dart';
import 'package:ideascape/data_layer/repositories/space_view_repository.dart';
import 'package:ideascape/flavor_config.dart';

import 'remote_api_data_source.dart';

Future initializeDependencies() async {
  getIt.registerSingletonAsync<RestApiSource>(() async {
    return RestApiSource(
      baseUrl: FlavorConfig.instance.apiUrl,
      token: '',
      onUnauthorized: () async {},
      onSaveNewAuth: (responseUserModel) async {},
      onSaveNewTokens:
          ({
            required String refreshToken,
            required String accessToken,
          }) async {},
    );
  });

  await getIt.isReady<RestApiSource>();

  getIt.registerLazySingleton(() => SpaceDashboardRepository(getIt()));

  getIt.registerLazySingleton(() => SpaceViewRepository());
}
