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

Future<CategoryInfo> getCategory(Function callback) async {
  Response response = await DioConfig.singleton.dio.get(url_category);
  var category = AllCategory(response.data);
  if (category.retCode == success.toString()) callback(category.result);
  return category.result;
}

Future<int> getCookbookListByCid(Function callback,
    {String cid, int page, int size = 20}) async {
  var data = FormData.from({'page': page, 'size': size});
  if (cid != null) {
    data.add('cid', cid);
  }
  var response = await DioConfig.singleton.dio
      .get(url_cookbook_by_category, queryParameters: data);
//    response.statusCode == 200
  var allCookbook = AllCookbook(response.data);
  callback(allCookbook.result);
  return 1;
}

Future<int> getCookbookListByName(
    String name, int page, Function callback) async {
  var data = FormData.from({'name': name, 'page': page, 'size': 20});
  var response = await DioConfig.singleton.dio
      .get(url_cookbook_by_category, queryParameters: data);
  var allCookbook = AllCookbook(response.data);
  if (allCookbook != null && allCookbook.result != null)
    callback(allCookbook.result.list);
  return 1;
}

Future<int> getCookbook(String id, Function callback) async {
  var response = await DioConfig.singleton.dio.get(url_cookbook_by_id + id);
  callback(NetCookbook(response.data).result);
  return 1;
}
