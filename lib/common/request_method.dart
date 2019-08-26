import '../bean/index.dart';
import 'dio_util.dart';

const GET = 'get';
const POST = 'post';

class RequestApi {
  RequestApi._();

  static final _dio = DioUtil.getInstance().dio;

  static Future<List<BannerData>> getBannerList() {
    return _dio.get('api/bannerList').then((response) {
      List<BannerData> res = [];
      var requestData = response.data['data'];
      for (var dataItem in requestData == null ? [] : requestData) {
        res.add(dataItem == null ? null : new BannerData.fromJson(dataItem));
      }
      return res;
    });
  }

  static Future<List<RecommendData>> getRecommendList() {
    return _dio.get('api/getRecommendList').then((response) {
      List<RecommendData> res = [];
      var requestData = response.data['data'];
      for (var dataItem in requestData == null ? [] : requestData) {
        res.add(dataItem == null ? null : new RecommendData.fromJson(dataItem));
      }
      return res;
    });
  }

  static Future<List<SingerGroup>> getSingerList() {
    return _dio.get('api/getSingerList').then((response) {
      List<SingerGroup> res = [];
      var requestData = response.data['data'];
      for (var dataItem in requestData == null ? [] : requestData) {
        res.add(dataItem == null ? null : new SingerGroup.fromJson(dataItem));
      }
      return res;
    });
  }

  static Future<List<RankTop>> getRankList() {
    return _dio.get('api/getRankList').then((response) {
      List<RankTop> res = [];
      var requestData = response.data['data'];
      for (var dataItem in requestData == null ? [] : requestData) {
        res.add(dataItem == null ? null : new RankTop.fromJson(dataItem));
      }
      return res;
    });
  }

  static Future<RecommendSong> getRecommendSongList(String disstid) {
    return _dio.get('api/getRecommendSongList', queryParameters: {'disstid': disstid}).then((response) {
      final requestData = response.data['data'];
      return RecommendSong.fromJson(requestData);
    });
  }

  static Future<SingerSong> getSingerSongList(String singermid) {
    return _dio.get('api/getSingerSongList', queryParameters: {'singermid': singermid}).then((response) {
      final requestData = response.data['data'];
      return SingerSong.fromJson(requestData);
    });
  }

  static Future<RankSong> getRankSongList(int topid) {
    return _dio.get('api/getRankSongList', queryParameters: {'topid': topid}).then((response) {
      final requestData = response.data['data'];
      return RankSong.fromJson(requestData);
    });
  }
}
