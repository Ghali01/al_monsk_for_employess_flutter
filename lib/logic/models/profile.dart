class ProfileState {
  Map? data;
  bool? online;
  ProfileState({
    this.data,
    this.online,
  });

  ProfileState copyWith({
    Map? data,
    bool? online,
  }) {
    return ProfileState(
      data: data ?? this.data,
      online: online ?? this.online,
    );
  }
}
