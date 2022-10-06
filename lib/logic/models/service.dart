class ServiceState {
  bool connected;
  ServiceState({
    this.connected = false,
  });

  ServiceState copyWith({
    bool? connected,
  }) {
    return ServiceState(
      connected: connected ?? this.connected,
    );
  }
}
