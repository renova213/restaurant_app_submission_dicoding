import 'package:equatable/equatable.dart';

class AppSplashState extends Equatable {
  final bool isReady;

  const AppSplashState({required this.isReady});

  factory AppSplashState.initial() {
    return const AppSplashState(isReady: false);
  }

  AppSplashState copyWith({bool? isReady}) {
    return AppSplashState(isReady: isReady ?? this.isReady);
  }

  @override
  List<Object> get props => [isReady];
}
