import 'dart:ui';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:vv_shop/config/config.dart';
import 'dart:developer';
import 'package:vv_shop/entity/FocusEntity.dart';
import 'package:vv_shop/entity/product_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusItem> _focusData = [];
  List<ProductItem> _hotProductList = [];
  List<ProductItem> _recommandProductList = [];
  _getFocusData() async {
    var api = "${Config.domain}api/focus";
    var result = await Dio().get(api);
    var focusList = FocusEntity.fromJson(result.data);
    setState(() {
      _focusData = focusList.result!;
    });
    log("result: ${result} \n\n data: ${result.data}");
  }

  _getHotProductData() async {
    var api = "${Config.domain}api/plist?is_hot=1";
    var result = await Dio().get(api);
    log("${api}result: \n\n ${result}");
    var productList = ProductEntity.fromJson(result.data);
    setState(() {
      _hotProductList = productList.result;
    });
  }

  _getBestProductData() async {
    var api = "${Config.domain}api/plist?is_best=1";
    var result = await Dio().get(api);
    log("${api}result: \n\n ${result}");
    setState(() {
      _recommandProductList = ProductEntity.fromJson(result.data).result;
    });
  }

  @override
  void initState() {
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
    super.initState();
  }

  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (context, index) {
            String pic = _focusData[index].pic;
            pic = Config.domain + pic.replaceAll('\\', "/");
            return Image.network(pic, fit: BoxFit.fill);
          },
          itemCount: _focusData.length,
          pagination: const SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
  }

  Widget _titleWidget(String title) {
    return Container(
      height: 16,
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(border: Border(left: BorderSide(color: Colors.red, width: 5))),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  Widget _hotProductListWidget() {
    return Container(
      height: 117,
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          String pic = _hotProductList[index].pic;
          pic = Config.domain + pic.replaceAll("\\", '/');
          return Column(
            children: [
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(right: 10),
                child: Image.network(pic, fit: BoxFit.cover),
              ),
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 22,
                child: Text("￥${_hotProductList[index].price}", style: const TextStyle(color: Colors.red)),
              )
            ],
          );
        },
        itemCount: _hotProductList.length,
      ),
    );
  }

  Widget _recProductItemWidget(context) {
    var itemWidth = (MediaQuery.of(context).size.width - 30) / 2;
    log("${MediaQuery.of(context).size.width}");
    log("bestProductCount ${_recommandProductList.length}");
    return Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: _recommandProductList.map((e) {
              String pic = e.pic;
              pic = Config.domain + pic.replaceAll("\\", "/");
              return Container(
                padding: const EdgeInsets.all(10),
                width: itemWidth,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Image.network(pic, fit: BoxFit.cover),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(e.title,
                          maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.black54)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e.oldPrice,
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            "${e.price}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        children: [
          _swiperWidget(),
          const SizedBox(height: 10),
          _titleWidget("猜你喜欢"),
          const SizedBox(height: 10),
          _hotProductListWidget(),
          const SizedBox(height: 10),
          _titleWidget("热门推荐"),
          _recProductItemWidget(context)
        ],
      ),
    );
  }
}
