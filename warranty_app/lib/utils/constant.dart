enum UserRole { customer, supporter, employee }

enum Status {
  pending,
  inProgress,
  completed,
  accepted,
  unaccepted,
  canceled,
  inCompleted,
}

enum ColorStatus {
  red,
  green,
  blue,
  accept,
  unaccepted,
}

extension ColorExt on ColorStatus {
  String get name {
    switch (this) {
      case ColorStatus.red:
        return 'Red';
      case ColorStatus.green:
        return 'Green';
      case ColorStatus.accept:
        return 'Accepted';
      case ColorStatus.unaccepted:
        return 'Unaccepted';
      default:
        return 'Blue';
    }
  }

  int get hexCode {
    const hexCodes = [
      0xFFF44336,
      0xFFFFE57F,
      0xFF0277BD,
      0xFF4AA366,
      0xFF2D2D38
    ];
    return hexCodes[index];
  }
}
