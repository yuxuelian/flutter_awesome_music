import 'dart:convert' show json;

import 'song_data.dart';

class SingerSong {
  String singerName;
  String singerAvatar;
  List<SongData> songList;

  SingerSong.fromParams({this.singerName, this.singerAvatar, this.songList});

  factory SingerSong(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SingerSong.fromJson(json.decode(jsonStr)) : new SingerSong.fromJson(jsonStr);

  SingerSong.fromJson(jsonRes) {
    singerName = jsonRes['singerName'];
    singerAvatar = jsonRes['singerAvatar'];
    songList = jsonRes['songList'] == null ? null : [];

    for (var songListItem in songList == null ? [] : jsonRes['songList']) {
      songList.add(songListItem == null ? null : SongData.fromJson(songListItem));
    }
  }

  @override
  String toString() {
    return '{"singerName": ${singerName != null ? '${json.encode(singerName)}' : 'null'},"singerAvatar": ${singerAvatar != null ? '${json.encode(singerAvatar)}' : 'null'},"songList": $songList}';
  }
}
