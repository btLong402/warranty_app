class Feedback {
  final int _feedbackId;
  final int _reportId;
  final String _customerId;
  final String _toUserId;
  final String _feedback;
  final DateTime _createAt;
  get feedbackId => _feedbackId;

  get reportId => _reportId;

  get customerId => _customerId;

  get toUserId => _toUserId;

  get feedback => _feedback;

  get createAt => _createAt;

  const Feedback(
      {required int feedbackId,
      required int reportId,
      required String customerId,
      required String toUserId,
      required String feedback,
      required DateTime createAt})
      : _feedbackId = feedbackId,
        _reportId = reportId,
        _customerId = customerId,
        _toUserId = toUserId,
        _feedback = feedback,
        _createAt = createAt;
}
