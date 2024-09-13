import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tmbd/core/constants/constants.dart';
import 'package:movie_app_tmbd/features/home/presentation/bloc/movie/movie_bloc.dart';
import 'package:movie_app_tmbd/features/main/presentation/cubit/tab_box_cubit.dart';

import 'core/utils/utils.dart';
import 'injector_container.dart' as di;

import 'app.dart';
import 'injector_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) Bloc.observer = LogBlocObserver();

  di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt.get<MovieBloc>()
            ..add(
              const GetMovieByCategory(
                category: Constants.topRated,
                page: 1,
              ),
            ),
        ),
        BlocProvider.value(value: getIt.get<TabBoxCubit>()),
      ],
      child: const App(),
    ),
  );
}
