class CartIndexList {
  final List<int> _indexUrls = [];

  static final CartIndexList _instance = CartIndexList._internal();

  factory CartIndexList() {
    return _instance;
  }

  CartIndexList._internal();

  List<int> get indexUrls => _indexUrls;

  void addIndex(int index) {
    _indexUrls.add(index);
  }
}
