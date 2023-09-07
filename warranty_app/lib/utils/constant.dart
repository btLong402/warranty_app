enum UserRole { customer, supporter, employee }

enum Status {
  pending,
  inProgress,
  completed,
  canceled,
  inCompleted,
  accepted,
  unaccepted
}

enum ColorStatus {
  red,
  green,
  blue,
}

extension ColorExt on ColorStatus {
  String get name {
    switch (this) {
      case ColorStatus.red:
        return 'Red';
      case ColorStatus.green:
        return 'Green';
      default:
        return 'Blue';
    }
  }

  int get hexCode {
    const hexCodes = [0xFFF44336,0xFFFFE57F, 0xFF0277BD];
    return hexCodes[index];
  }
}
