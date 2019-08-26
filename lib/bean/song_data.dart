import 'dart:convert' show json;

class SongData {
  String image;
  String singername;
  String songmid;
  String songname;
  String url;

  SongData.fromParams({this.image, this.singername, this.songmid, this.songname, this.url});

  factory SongData(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SongData.fromJson(json.decode(jsonStr)) : new SongData.fromJson(jsonStr);

  SongData.fromJson(jsonRes) {
    image = jsonRes['image'];
    singername = jsonRes['singername'];
    songmid = jsonRes['songmid'];
    songname = jsonRes['songname'];
    url = jsonRes['url'];
  }

  @override
  String toString() {
    return '{"image": ${image != null ? '${json.encode(image)}' : 'null'},"singername": ${singername != null ? '${json.encode(singername)}' : 'null'},"songmid": ${songmid != null ? '${json.encode(songmid)}' : 'null'},"songname": ${songname != null ? '${json.encode(songname)}' : 'null'},"url": ${url != null ? '${json.encode(url)}' : 'null'}}';
  }
}
