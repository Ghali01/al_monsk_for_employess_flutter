class LoginState {
  bool loading;
  bool done;
  String error;
  LoginState({
    this.loading = false,
    this.done = false,
    this.error = '',
  });

  LoginState copyWith({
    bool? loading,
    bool? done,
    String? error,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      done: done ?? this.done,
      error: error ?? this.error,
    );
  }
}
