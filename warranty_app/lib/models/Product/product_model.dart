class Product {
  final int _productId;
  final String _name;

  const Product({required int productId, required String name})
      : _productId = productId,
        _name = name;
  get productId => _productId;
  get name => _name;
}
