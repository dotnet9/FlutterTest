class FocusModel {
  List<FocusItemModel> result = [];
  FocusModel({required this.result});
  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      json['result'].forEach((v) {
        result.add(FocusItemModel.fromJson(v));
      });
    }
  }
}

class FocusItemModel {
  String? sID;
  String? title;
  String? status;
  String? pic;
  String? url;

  FocusItemModel({this.sID, this.title, this.status, this.pic, this.url});

  FocusItemModel.fromJson(Map<String, dynamic> jsonData) {
    sID = jsonData['_id'];
    title = jsonData['title'];
    status = jsonData['status'];
    pic = jsonData['pic'];
    url = jsonData['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data['id'] = sID;
    _data['title'] = title;
    _data['status'] = status;
    _data['pic'] = pic;
    _data['url'] = url;
    return _data;
  }
}
