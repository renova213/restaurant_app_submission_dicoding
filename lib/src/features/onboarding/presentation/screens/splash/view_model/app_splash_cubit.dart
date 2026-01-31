import 'package:bloc/bloc.dart';

import 'app_splash_state.dart';

class AppSplashCubit extends Cubit<AppSplashState> {
  AppSplashCubit() : super(AppSplashState.initial());

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(isReady: true));
  }
}
