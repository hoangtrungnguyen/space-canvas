import 'package:ideascape/data_layer/web_socket_client.dart';
import 'package:ideascape/domain/space_data_service.dart';
import 'package:ideascape/features/space/view/bloc/page_bloc.dart';

import 'aliases.dart';

Future initializeDependencies() async {
  getIt.registerSingletonAsync<WebSocketClient>(() async {
    final client = WebSocketClient();
    return client;
  });

  getIt.registerLazySingleton<SpaceDataService>(() => SpaceDataService());

  getIt.registerFactoryParam<SpacePageBloc, String, void>(
    (id, _) =>
        SpacePageBloc(id: id, spaceDataService: getIt<SpaceDataService>()),
  );
}
