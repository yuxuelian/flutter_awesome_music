import 'dart:convert' show json;

class BannerData {
  int id;
  String linkUrl;
  String picUrl;

  BannerData.fromParams({this.id, this.linkUrl, this.picUrl});

  factory BannerData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new BannerData.fromJson(json.decode(jsonStr)) : new BannerData.fromJson(jsonStr);

  BannerData.fromJson(jsonRes) {
    id = jsonRes['id'];
    linkUrl = jsonRes['linkUrl'];
    picUrl = jsonRes['picUrl'];
  }

  @override
  String toString() {
    return '{"id": $id,"linkUrl": ${linkUrl != null ? '${json.encode(linkUrl)}' : 'null'},"picUrl": ${picUrl != null ? '${json.encode(picUrl)}' : 'null'}}';
  }
}
