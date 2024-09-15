import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_tmbd/features/search/presentation/page/search_page.dart';
import 'package:movie_app_tmbd/features/watchlist/presentation/page/watchlist_page.dart';

import '../../../../core/core.dart';
import '../cubit/tab_box_cubit.dart';
import '../../../home/presentation/page/home_page.dart';

part 'mixin/main_mixin.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with MainMixin {
  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    WatchlistPage(),
  ];

  static final List<String> _tabBoxIconsPath = [
    AppAssets.icons.home.path,
    AppAssets.icons.search.path,
    AppAssets.icons.save.path,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBoxCubit, TabBoxState>(
      buildWhen: (previous, current) =>
          previous.tabBoxCurrentIndex != current.tabBoxCurrentIndex,
      builder: (context, state) => PopScope(
        canPop: state.canPop,
        onPopInvokedWithResult: _onPopInvoked,
        child: Scaffold(
          body: _pages[state.tabBoxCurrentIndex],
          bottomNavigationBar: Container(
            padding: AppUtils.kPaddingHor32Ver8,
            decoration: const BoxDecoration(
              color: AppColors.mainColor,
              border: Border(
                top: BorderSide(color: AppColors.blue, width: 2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _tabBoxIconsPath.length,
                (index) => GestureDetector(
                  onTap: () => context
                      .read<TabBoxCubit>()
                      .changeTabBoxIndex(newIndex: index),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        _tabBoxIconsPath[index],
                        colorFilter: state.tabBoxCurrentIndex == index
                            ? const ColorFilter.mode(
                                AppColors.blue,
                                BlendMode.srcIn,
                              )
                            : null,
                      ),
                      AppUtils.kGap8,
                      Text(
                        Constants.tabBoxLabels[index],
                        style: TextStyle(
                          color: state.tabBoxCurrentIndex == index
                              ? AppColors.blue
                              : const Color(0xFF67686d),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
