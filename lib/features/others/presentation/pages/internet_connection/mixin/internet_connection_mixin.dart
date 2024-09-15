part of '../internet_connection_page.dart';

mixin InternetConnectionMixin on State<NoConnectionPage> {
  @override
  void initState() {
    super.initState();

    getIt.get<Connectivity>().onConnectivityChanged.listen(
      (List<ConnectivityResult> result) {
        if (result.contains(ConnectivityResult.wifi) ||
            result.contains(ConnectivityResult.mobile)) {
          if (!mounted) return;

          getIt.get<MovieBloc>().add(const GetAllMoviesEvent());

          context.pop();
        }
      },
    );
  }
}
