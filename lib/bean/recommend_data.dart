import 'dart:convert' show json;

class RecommendData {
  String dissname;
  String disstid;
  String imgurl;
  String name;

  RecommendData.fromParams({this.dissname, this.disstid, this.imgurl, this.name});

  factory RecommendData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RecommendData.fromJson(json.decode(jsonStr)) : new RecommendData.fromJson(jsonStr);

  RecommendData.fromJson(jsonRes) {
    dissname = jsonRes['dissname'];
    disstid = jsonRes['disstid'];
    imgurl = jsonRes['imgurl'];
    name = jsonRes['name'];
  }

  @override
  String toString() {
    return '{"dissname": ${dissname != null ? '${json.encode(dissname)}' : 'null'},"disstid": ${disstid != null ? '${json.encode(disstid)}' : 'null'},"imgurl": ${imgurl != null ? '${json.encode(imgurl)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'}}';
  }
}
