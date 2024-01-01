class SearchModel {
  List<SearchData>? searchData;

  SearchModel({this.searchData});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['search_data'] != null) {
      searchData = <SearchData>[];
      json['search_data'].forEach((v) {
        searchData!.add(new SearchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchData != null) {
      data['search_data'] = this.searchData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchData {
  String? id;
  String? title;
  String? discount;

  SearchData({this.id, this.title, this.discount});

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['discount'] = this.discount;
    return data;
  }
}
