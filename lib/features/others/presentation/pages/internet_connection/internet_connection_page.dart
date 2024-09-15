import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../../core/core.dart';
import '../../../../../injector_container.dart';
import '../../../../home/presentation/bloc/movie/movie_bloc.dart';

part 'mixin/internet_connection_mixin.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({super.key});

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage>
    with InternetConnectionMixin {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppAssets.lottie.loading.lottie(
                height: DeviceScreen.w(context) / 2.5,
                width: DeviceScreen.w(context) / 2.5,
              ),
              SizedBox(
                width: DeviceScreen.w(context) / 1.4,
                child: const Text(
                  'No internet connection found. Please check your connection and try again',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}