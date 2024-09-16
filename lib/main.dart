import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/utils/utils.dart';
import 'injector_container.dart';
import 'injector_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) Bloc.observer = LogBlocObserver();

  di.init();

  /// To store app secrets
  dotenv.load(fileName: '.env');

  /// To store bloc's last state to local storage
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt.get<MovieBloc>()..add(const GetAllMoviesEvent()),
        ),
        BlocProvider.value(value: getIt.get<TabBoxCubit>()),
        BlocProvider.value(value: getIt.get<WatchListBloc>()),
      ],
      child: const App(),
    ),
  );
}
