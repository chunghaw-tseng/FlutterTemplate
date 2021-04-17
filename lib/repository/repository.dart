import 'package:flutter_template/repository/apiProviderService.dart';

class Repository {
  ApiProviderService apiProvider = new ApiProviderService();

  /// Repository calls should be like this
  Future<List<String>> fetchData() async {
    final response = await apiProvider.get("/dummydata");
    var dres = response["studylist"];
    var url = response["url"];
    List<String> latestStudylist = [];
    // for (int i = 0; i < dres.length; i++) {
    //   latestStudylist.add(Study.fromJson(dres[i]));
    // }
    print("Dummy Data Length ${latestStudylist.length}");
    return latestStudylist;
  }
}
