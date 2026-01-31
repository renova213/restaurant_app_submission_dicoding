import 'dart:async';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/config.dart';
import 'src/di/app_repositories.dart';
import 'src/features/restaurant/presentation/screens/dashboard/dashboard.dart';
import 'src/routes/app_router.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _holdTimer;
  static const _holdDuration = Duration(seconds: 2);

  void _startHold() {
    _holdTimer?.cancel();
    _holdTimer = Timer(_holdDuration, _onHoldTriggered);
  }

  void _cancelHold() {
    _holdTimer?.cancel();
  }

  void _onHoldTriggered() {
    ChuckerFlutter.showChuckerScreen();
  }

  @override
  void dispose() {
    _holdTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.deferToChild,
      onPointerDown: (_) => _startHold(),
      onPointerUp: (_) => _cancelHold(),
      onPointerCancel: (_) => _cancelHold(),
      child: MultiRepositoryProvider(
        providers: appRepositories,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (_) {
                return ThemeCubit();
              },
            ),
            ...appCubits,
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp.router(
                themeMode: themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                routerConfig: appRouter,
                builder: (context, child) {
                  return Scaffold(
                    body: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: child ?? const SizedBox.shrink(),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
