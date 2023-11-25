U? withNonNullOrNull<T, U>(T? value, U Function(T) action) {
  if (value == null) {
    return null;
  } else {
    return action(value);
  }
}
