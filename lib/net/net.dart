import 'package:cook/entity/cook_bean.dart';

import 'config_dio.dart';
import 'package:dio/dio.dart';

const String appKey = 'key';
const String baseUrl = 'http://apicloud.mob.com/v1/cook';
const String url_category = '/category/query?key=$appKey';

///请求参数(搜索--按name， 按 cid)
///cid	string	否	 标签ID(末级分类标签)
///name	string	否	 菜谱名称	红烧肉
///page	int	否	 起始页(默认1)	1
///size	int	否	 返回数据条数(默认20)	20
const String url_cookbook_by_category = '/menu/search?key=$appKey';
const String url_cookbook_by_name = '/menu/search?key=$appKey&name=';

///请求参数
///id	string	是	菜谱ID
const String url_cookbook_by_id = '/menu/query?key=$appKey&id=';

void getCategory(Function callback) async {
  Response response = await DioConfig.singleton.dio.get(url_category);
  var category = AllCategory(response.data);
  if (category.retCode == success.toString()) callback(category.result);
}

void getCookbookListByCid(String cid, int page, Function callback) {
  var data = FormData.from({'cid': cid, 'page': page, 'size': 20});
  DioConfig.singleton.dio
      .get(url_cookbook_by_category, queryParameters: data)
      .then((response) {
//    response.statusCode == 200
    var allCookbook = AllCookbook(response.data);
    callback(allCookbook.result);
  });
}

void getCookbookListByName(String name, int page, Function callback) {
  var data = FormData.from({'name': name, 'page': page, 'size': 20});
  DioConfig.singleton.dio
      .get(url_cookbook_by_category, queryParameters: data)
      .then((response) {
    var allCookbook = AllCookbook(response.data);
    if (allCookbook != null && allCookbook.result != null)
      callback(allCookbook.result.list);
  });
}

void getCookbook(String id, Function callback) {
  DioConfig.singleton.dio.get(url_cookbook_by_id + id).then((response) {
    callback(NetCookbook(response.data).result);
  });
}
