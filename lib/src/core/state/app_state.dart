enum AppState { initial, loading, loaded, error, empty }

extension AppStateExtension on AppState {
  bool get isInitial => this == AppState.initial;
  bool get isLoading => this == AppState.loading;
  bool get isLoaded => this == AppState.loaded;
  bool get isError => this == AppState.error;
  bool get isEmpty => this == AppState.empty;
}
