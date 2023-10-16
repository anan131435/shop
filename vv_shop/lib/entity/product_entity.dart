class ProductEntity {
  ProductEntity({
    required this.result,
  });
  late final List<ProductItem> result;

  ProductEntity.fromJson(Map<String, dynamic> json){
    result = List.from(json['result']).map((e)=>ProductItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['result'] = result.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProductItem {
  ProductItem({
    required this.id,
    required this.title,
    required this.cid,
    required this.price,
    required this.oldPrice,
    required this.pic,
    required this.sPic,
  });
  late final String id;
  late final String title;
  late final String cid;
  late final int price;
  late final String oldPrice;
  late final String pic;
  late final String sPic;

  ProductItem.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    oldPrice = json['old_price'];
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['title'] = title;
    _data['cid'] = cid;
    _data['price'] = price;
    _data['old_price'] = oldPrice;
    _data['pic'] = pic;
    _data['s_pic'] = sPic;
    return _data;
  }
}