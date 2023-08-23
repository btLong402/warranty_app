import 'package:warranty_app/utils/status.dart';

class Report {
  final int _reportId;
  final String _customerId;
  final int _productId;
  Status _status;
  final DateTime _createAt;
  final String _description;
  Report(
      {required int reportId,
      required String customerId,
      required int productId,
      required String description,
      required DateTime createAt})
      : _reportId = reportId,
        _customerId = customerId,
        _productId = productId,
        _createAt = createAt,
        _status = Status.pending,
        _description = description;
  get reportId => _reportId;

  get customerId => _customerId;

  get productId => _productId;

  get status => _status;

  set status(value) => _status = value;

  get createAt => _createAt;

  get description => _description;
}
