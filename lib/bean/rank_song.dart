import 'dart:convert' show json;

import 'song_data.dart';

class RankSong {
  String rankName;
  String rankImage;
  List<SongData> songList;

  RankSong.fromParams({this.rankName, this.rankImage, this.songList});

  factory RankSong(jsonStr) => jsonStr == null ? null : jsonStr is String ? new RankSong.fromJson(json.decode(jsonStr)) : new RankSong.fromJson(jsonStr);

  RankSong.fromJson(jsonRes) {
    rankName = jsonRes['rankName'];
    rankImage = jsonRes['rankImage'];
    songList = jsonRes['songList'] == null ? null : [];

    for (var songListItem in songList == null ? [] : jsonRes['songList']) {
      songList.add(songListItem == null ? null : SongData.fromJson(songListItem));
    }
  }

  @override
  String toString() {
    return '{"rankName": ${rankName != null ? '${json.encode(rankName)}' : 'null'},"rankImage": ${rankImage != null ? '${json.encode(rankImage)}' : 'null'},"songList": $songList}';
  }
}
