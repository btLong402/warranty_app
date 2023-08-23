// ignore_for_file: unused_field

import 'package:warranty_app/utils/status.dart';

class ReportSession {
  final int _reportSessionId;
  final int _reportId;
  final String _supportId;
  final DateTime _createAt;
  final String _description;
  Status _status;

  ReportSession(
      {required int reportSessionId,
      required String supportId,
      required DateTime createAt,
      required String description,
      required int reportId})
      : _reportSessionId = reportSessionId,
        _supportId = supportId,
        _createAt = createAt,
        _description = description,
        _status = Status.inProgress,
        _reportId = reportId;

  get reportSessionId => _reportSessionId;

  get supportId => _supportId;

  get createAt => _createAt;

  get description => _description;

  get status => _status;

  set status(value) => _status = value;
}
