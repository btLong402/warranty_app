import 'package:warranty_app/utils/status.dart';

class Task {
  final int _taskId;
  final int _reportId;
  final String _employeeId;
  final String _creatorId;
  final DateTime _createAt;

  Status _status;

  Task(
      {required int taskId,
      required int reportId,
      required String employeeId,
      required String creatorId,
      required DateTime createAt})
      : _taskId = taskId,
        _reportId = reportId,
        _employeeId = employeeId,
        _creatorId = creatorId,
        _createAt = createAt,
        _status = Status.pending;
  get taskId => _taskId;

  get reportId => _reportId;

  get employeeId => _employeeId;

  get creatorId => _creatorId;

  get createAt => _createAt;

  get status => _status;

  set status(value) => _status = value;
}
