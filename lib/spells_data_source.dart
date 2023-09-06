import 'package:dio/dio.dart';

const apiPath = 'https://www.dnd5eapi.co/api';

class SpellsDataSource {
  final _dio = Dio();

  Future<void> getAllSpellNames() async {
    final response = await _dio.get(
      apiPath + '/spells',
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    // final json = response.data.toString();
    // Map<String, dynamic> data = jsonDecode(response.data);
    List<dynamic> results = response.data["results"];
    List<String> names =
        results.map((result) => result["name"] as String).toList();
    print(names);
  }
}
