import 'dart:convert' show json;

import 'song_data.dart';

class RecommendSong {
  String dissname;
  String logo;
  List<SongData> songList;

  RecommendSong.fromParams({this.dissname, this.logo, this.songList});

  factory RecommendSong(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RecommendSong.fromJson(json.decode(jsonStr)) : new RecommendSong.fromJson(jsonStr);

  RecommendSong.fromJson(jsonRes) {
    dissname = jsonRes['dissname'];
    logo = jsonRes['logo'];
    songList = jsonRes['songList'] == null ? null : [];

    for (var songListItem in songList == null ? [] : jsonRes['songList']) {
      songList.add(songListItem == null ? null : SongData.fromJson(songListItem));
    }
  }

  @override
  String toString() {
    return '{"dissname": ${dissname != null ? '${json.encode(dissname)}' : 'null'},"logo": ${logo != null ? '${json.encode(logo)}' : 'null'},"songList": $songList}';
  }
}
