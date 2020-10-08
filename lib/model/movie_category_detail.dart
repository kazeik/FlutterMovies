///视频分类详情模型
class MacMovieCategoryDetail {
  int typeId;
  String typeName;
  String typeEn;
  int typeSort;
  int typeMid;
  int typePid;
  int typeStatus;
  String typeTpl;
  String typeTplList;
  String typeTplDetail;
  String typeTplPlay;
  String typeTplDown;
  String typeKey;
  String typeDes;
  String typeTitle;
  String typeUnion;
  TypeExtend typeExtend;
  String typeLogo;
  String typePic;
  String typeJumpurl;

  MacMovieCategoryDetail(
      {this.typeId,
      this.typeName,
      this.typeEn,
      this.typeSort,
      this.typeMid,
      this.typePid,
      this.typeStatus,
      this.typeTpl,
      this.typeTplList,
      this.typeTplDetail,
      this.typeTplPlay,
      this.typeTplDown,
      this.typeKey,
      this.typeDes,
      this.typeTitle,
      this.typeUnion,
      this.typeExtend,
      this.typeLogo,
      this.typePic,
      this.typeJumpurl});

  MacMovieCategoryDetail.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    typeEn = json['type_en'];
    typeSort = json['type_sort'];
    typeMid = json['type_mid'];
    typePid = json['type_pid'];
    typeStatus = json['type_status'];
    typeTpl = json['type_tpl'];
    typeTplList = json['type_tpl_list'];
    typeTplDetail = json['type_tpl_detail'];
    typeTplPlay = json['type_tpl_play'];
    typeTplDown = json['type_tpl_down'];
    typeKey = json['type_key'];
    typeDes = json['type_des'];
    typeTitle = json['type_title'];
    typeUnion = json['type_union'];
    typeExtend = json['type_extend'] != null
        ? new TypeExtend.fromJson(json['type_extend'])
        : null;
    typeLogo = json['type_logo'];
    typePic = json['type_pic'];
    typeJumpurl = json['type_jumpurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['type_en'] = this.typeEn;
    data['type_sort'] = this.typeSort;
    data['type_mid'] = this.typeMid;
    data['type_pid'] = this.typePid;
    data['type_status'] = this.typeStatus;
    data['type_tpl'] = this.typeTpl;
    data['type_tpl_list'] = this.typeTplList;
    data['type_tpl_detail'] = this.typeTplDetail;
    data['type_tpl_play'] = this.typeTplPlay;
    data['type_tpl_down'] = this.typeTplDown;
    data['type_key'] = this.typeKey;
    data['type_des'] = this.typeDes;
    data['type_title'] = this.typeTitle;
    data['type_union'] = this.typeUnion;
    if (this.typeExtend != null) {
      data['type_extend'] = this.typeExtend.toJson();
    }
    data['type_logo'] = this.typeLogo;
    data['type_pic'] = this.typePic;
    data['type_jumpurl'] = this.typeJumpurl;
    return data;
  }
}

class TypeExtend {
  String extendClass;
  String extendArea;
  String extendLang;
  String extendYear;
  String extendStar;
  String extendDirector;
  String extendState;
  String extendVersion;

  TypeExtend(
      {this.extendClass,
      this.extendArea,
      this.extendLang,
      this.extendYear,
      this.extendStar,
      this.extendDirector,
      this.extendState,
      this.extendVersion});

  TypeExtend.fromJson(Map<String, dynamic> json) {
    extendClass = json['class'];
    extendArea = json['area'];
    extendLang = json['lang'];
    extendYear = json['year'];
    extendStar = json['star'];
    extendDirector = json['director'];
    extendState = json['state'];
    extendVersion = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.extendClass;
    data['area'] = this.extendArea;
    data['lang'] = this.extendLang;
    data['year'] = this.extendYear;
    data['star'] = this.extendStar;
    data['director'] = this.extendDirector;
    data['state'] = this.extendState;
    data['version'] = this.extendVersion;
    return data;
  }
}
