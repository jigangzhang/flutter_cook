import 'package:cook/entity/cook_bean.dart';

import 'config_dio.dart';
import 'package:dio/dio.dart';

const String appKey = 'key';
const String baseUrl = 'http://apicloud.mob.com/v1/cook';
const String url_category = '/category/query?key=$appKey';

///请求参数(搜索--按name， 按 cid)
///cid	string	否	 标签ID(末级分类标签)
///name	string	否	 菜谱名称	红烧肉
///page	int	否	起始页(默认1)	1
///size	int	否	返回数据条数(默认20)	20
const String url_cookbook_by_category = '/menu/search?key=$appKey&cid=';

///请求参数
///id	string	是	菜谱ID
const String url_cookbook_by_id = '/menu/query?key=$appKey&id=';

void getCategory() async {
  Response response = await DioConfig.singleton.dio.get(url_category);
  print(response.data.toString());
  var category = AllCategory(response.data);
  print(category.toString());
}
