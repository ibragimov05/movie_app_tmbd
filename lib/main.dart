import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/utils/utils.dart';
import 'injector_container.dart';
import 'injector_container.dart' as di;
import 'features/main/presentation/cubit/tab_box_cubit.dart';
import 'features/home/presentation/bloc/movie/movie_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) Bloc.observer = LogBlocObserver();

  di.init();

  await Future.wait([
    /// To store app secrets
    dotenv.load(fileName: '.env'),

    /// To store bloc's last state to local storage
    HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getTemporaryDirectory(),
    ),
  ]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt.get<MovieBloc>()..add(const GetAllMoviesEvent()),
        ),
        BlocProvider.value(value: getIt.get<TabBoxCubit>()),
      ],
      child: const App(),
    ),
  );
}
