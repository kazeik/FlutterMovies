class Upgradeinfo {
  int id;
  String title;
  String newFeature;
  String versionCode;
  String versionName;
  String packageName;
  String iosAppId;
  String apkUrl;

  Upgradeinfo(
      {this.id,
      this.title,
      this.newFeature,
      this.versionCode,
      this.versionName,
      this.packageName,
      this.iosAppId,
      this.apkUrl});

  Upgradeinfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    newFeature = json['newFeature'];
    versionCode = json['versionCode'];
    versionName = json['versionName'];
    packageName = json['packageName'];
    iosAppId = json['iosAppId'];
    apkUrl = json['apkUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['newFeature'] = this.newFeature;
    data['versionCode'] = this.versionCode;
    data['versionName'] = this.versionName;
    data['packageName'] = this.packageName;
    data['iosAppId'] = this.iosAppId;
    data['apkUrl'] = this.apkUrl;
    return data;
  }
}
