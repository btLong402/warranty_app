class Plan {
  final int _planId;
  final int _taskId;
  final int _itemErrorId;
  int? _itemPlaceId;
  get planId => _planId;

  get taskId => _taskId;

  get itemErrorId => _itemErrorId;

  get itemPlaceId => _itemPlaceId;

  set itemPlaceId(value) => _itemPlaceId = value;

  Plan(
      {required int planId,
      required int taskId,
      required int itemErrorId,
      int? itemPlaceId})
      : _planId = planId,
        _taskId = taskId,
        _itemErrorId = itemErrorId,
        _itemPlaceId = itemPlaceId;
}
