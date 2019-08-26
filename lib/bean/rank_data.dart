import 'dart:convert' show json;
import 'song_data.dart';

class RankTop {
  int id;
  int listenCount;
  int type;
  String picUrl;
  String topTitle;
  List<SongData> songList;

  RankTop.fromParams({this.id, this.listenCount, this.type, this.picUrl, this.topTitle, this.songList});

  factory RankTop(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RankTop.fromJson(json.decode(jsonStr)) : new RankTop.fromJson(jsonStr);

  RankTop.fromJson(jsonRes) {
    id = jsonRes['id'];
    listenCount = jsonRes['listenCount'];
    type = jsonRes['type'];
    picUrl = jsonRes['picUrl'];
    topTitle = jsonRes['topTitle'];
    songList = jsonRes['songList'] == null ? null : [];

    for (var songListItem in songList == null ? [] : jsonRes['songList']) {
      songList.add(songListItem == null ? null : new SongData.fromJson(songListItem));
    }
  }

  @override
  String toString() {
    return '{"id": $id,"listenCount": $listenCount,"type": $type,"picUrl": ${picUrl != null ? '${json.encode(picUrl)}' : 'null'},"topTitle": ${topTitle != null ? '${json.encode(topTitle)}' : 'null'},"songList": $songList}';
  }
}
