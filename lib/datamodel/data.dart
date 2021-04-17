class Data {
  String data;
  Data({this.data});

  /// Factory function used to turn the json data into an object
  factory Data.fromJson(Map<String, dynamic> js) {
    return Data(data: js["data"]);
  }

  /// Function to print the values as json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map();
    data["data"] = this.data;
    return data;
  }
}
