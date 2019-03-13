const int noData = 20101; //查询不到相关数据
const int invalidId = 20202; //菜谱id不合法
const int success = 200; //请求成功

class Result<T> {
  String retCode; //	string	是	返回码
  String msg; //string	是	返回说明
  T result;

  @override
  String toString() {
    return super.toString();
  }
}

class Category {
  String ctgId; //string	是	分类ID
  String name; //string	是	分类描述
  String parentId; //string	是	上层分类ID
}

class CategoryInfo {
  Category categoryInfo; //分类描述
  List<CategoryInfo> childs; //子类
}

class CookbookList {
  int total; //int	是	菜谱总条数
  int curPage; //int	是	当前页
  List<Cookbook> list; //菜谱
}

class Cookbook {
  List<String> ctgIds; //array	所属分类ID，多种
  String ctgTitles; //string	是	分类标签
  String menuId; //string	是	 菜谱id
  String name; //string	是 	菜谱名称
  Recipe recipe; //是	制作步骤
  String thumbnail; //string	是	预览图地址
}

class Recipe {
  String img; //"http:\/\/f2.mob.com\/null\/2015\/08\/19\/1439941528865.jpg",
  String ingredients; //"[\"肥瘦相间的猪肉、鸡翅中、冰糖、生姜、酒糟、红烧酱油、蚝油、生抽、盐。\"]",
  List<CookMethod> method; //步骤
  String sumary; //": "主题",
  String title; //"怎样做红烧肉翅"
}

class CookMethod {
  String img;
  String step;
}
