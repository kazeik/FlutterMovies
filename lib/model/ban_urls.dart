class BanUrls {
  List<String> banUrls;

  BanUrls({this.banUrls});

  BanUrls.fromJson(Map<String, dynamic> json) {
    banUrls = json['banUrls'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banUrls'] = this.banUrls;
    return data;
  }
}