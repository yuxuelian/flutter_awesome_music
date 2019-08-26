import 'dart:convert' show json;

class SingerGroup {
  String title;
  List<Singer> items;

  SingerGroup.fromParams({this.title, this.items});

  factory SingerGroup(jsonStr) => jsonStr == null ? null : jsonStr is String ? new SingerGroup.fromJson(json.decode(jsonStr)) : new SingerGroup.fromJson(jsonStr);

  SingerGroup.fromJson(jsonRes) {
    title = jsonRes['title'];
    items = jsonRes['items'] == null ? null : [];

    for (var itemsItem in items == null ? [] : jsonRes['items']) {
      items.add(itemsItem == null ? null : new Singer.fromJson(itemsItem));
    }
  }

  @override
  String toString() {
    return '{"title": ${title != null ? '${json.encode(title)}' : 'null'},"items": $items}';
  }
}

class Singer {
  String avatar;
  String id;
  String name;
  String title;

  Singer.fromParams({this.avatar, this.id, this.name, this.title});

  Singer.fromJson(jsonRes) {
    avatar = jsonRes['avatar'];
    id = jsonRes['id'];
    name = jsonRes['name'];
    title = jsonRes['title'];
  }

  @override
  String toString() {
    return '{"avatar": ${avatar != null ? '${json.encode(avatar)}' : 'null'},"id": ${id != null ? '${json.encode(id)}' : 'null'},"name": ${name != null ? '${json.encode(name)}' : 'null'},"title": ${title != null ? '${json.encode(title)}' : 'null'}}';
  }
}
