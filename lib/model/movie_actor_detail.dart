class MovieActorDetail {
  int actorId;
  int typeId;
  int typeId1;
  String actorName;
  String actorEn;
  String actorAlias;
  int actorStatus;
  int actorLock;
  String actorLetter;
  String actorSex;
  String actorColor;
  String actorPic;
  String actorBlurb;
  String actorRemarks;
  String actorArea;
  String actorHeight;
  String actorWeight;
  String actorBirthday;
  String actorBirtharea;
  String actorBlood;
  String actorStarsign;
  String actorSchool;
  String actorWorks;
  String actorTag;
  String actorClass;
  int actorLevel;
  String actorTime;
  int actorTimeAdd;
  int actorTimeHits;
  int actorTimeMake;
  int actorHits;
  int actorHitsDay;
  int actorHitsWeek;
  int actorHitsMonth;
  String actorScore;
  int actorScoreAll;
  int actorScoreNum;
  int actorUp;
  int actorDown;
  String actorTpl;
  String actorJumpurl;
  String actorContent;
  String typeName;

  MovieActorDetail(
      {this.actorId,
        this.typeId,
        this.typeId1,
        this.actorName,
        this.actorEn,
        this.actorAlias,
        this.actorStatus,
        this.actorLock,
        this.actorLetter,
        this.actorSex,
        this.actorColor,
        this.actorPic,
        this.actorBlurb,
        this.actorRemarks,
        this.actorArea,
        this.actorHeight,
        this.actorWeight,
        this.actorBirthday,
        this.actorBirtharea,
        this.actorBlood,
        this.actorStarsign,
        this.actorSchool,
        this.actorWorks,
        this.actorTag,
        this.actorClass,
        this.actorLevel,
        this.actorTime,
        this.actorTimeAdd,
        this.actorTimeHits,
        this.actorTimeMake,
        this.actorHits,
        this.actorHitsDay,
        this.actorHitsWeek,
        this.actorHitsMonth,
        this.actorScore,
        this.actorScoreAll,
        this.actorScoreNum,
        this.actorUp,
        this.actorDown,
        this.actorTpl,
        this.actorJumpurl,
        this.actorContent,
        this.typeName});

  MovieActorDetail.fromJson(Map<String, dynamic> json) {
    actorId = json['actor_id'];
    typeId = json['type_id'];
    typeId1 = json['type_id_1'];
    actorName = json['actor_name'];
    actorEn = json['actor_en'];
    actorAlias = json['actor_alias'];
    actorStatus = json['actor_status'];
    actorLock = json['actor_lock'];
    actorLetter = json['actor_letter'];
    actorSex = json['actor_sex'];
    actorColor = json['actor_color'];
    actorPic = json['actor_pic'];
    actorBlurb = json['actor_blurb'];
    actorRemarks = json['actor_remarks'];
    actorArea = json['actor_area'];
    actorHeight = json['actor_height'];
    actorWeight = json['actor_weight'];
    actorBirthday = json['actor_birthday'];
    actorBirtharea = json['actor_birtharea'];
    actorBlood = json['actor_blood'];
    actorStarsign = json['actor_starsign'];
    actorSchool = json['actor_school'];
    actorWorks = json['actor_works'];
    actorTag = json['actor_tag'];
    actorClass = json['actor_class'];
    actorLevel = json['actor_level'];
    actorTime = json['actor_time'];
    actorTimeAdd = json['actor_time_add'];
    actorTimeHits = json['actor_time_hits'];
    actorTimeMake = json['actor_time_make'];
    actorHits = json['actor_hits'];
    actorHitsDay = json['actor_hits_day'];
    actorHitsWeek = json['actor_hits_week'];
    actorHitsMonth = json['actor_hits_month'];
    actorScore = json['actor_score'];
    actorScoreAll = json['actor_score_all'];
    actorScoreNum = json['actor_score_num'];
    actorUp = json['actor_up'];
    actorDown = json['actor_down'];
    actorTpl = json['actor_tpl'];
    actorJumpurl = json['actor_jumpurl'];
    actorContent = json['actor_content'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actor_id'] = this.actorId;
    data['type_id'] = this.typeId;
    data['type_id_1'] = this.typeId1;
    data['actor_name'] = this.actorName;
    data['actor_en'] = this.actorEn;
    data['actor_alias'] = this.actorAlias;
    data['actor_status'] = this.actorStatus;
    data['actor_lock'] = this.actorLock;
    data['actor_letter'] = this.actorLetter;
    data['actor_sex'] = this.actorSex;
    data['actor_color'] = this.actorColor;
    data['actor_pic'] = this.actorPic;
    data['actor_blurb'] = this.actorBlurb;
    data['actor_remarks'] = this.actorRemarks;
    data['actor_area'] = this.actorArea;
    data['actor_height'] = this.actorHeight;
    data['actor_weight'] = this.actorWeight;
    data['actor_birthday'] = this.actorBirthday;
    data['actor_birtharea'] = this.actorBirtharea;
    data['actor_blood'] = this.actorBlood;
    data['actor_starsign'] = this.actorStarsign;
    data['actor_school'] = this.actorSchool;
    data['actor_works'] = this.actorWorks;
    data['actor_tag'] = this.actorTag;
    data['actor_class'] = this.actorClass;
    data['actor_level'] = this.actorLevel;
    data['actor_time'] = this.actorTime;
    data['actor_time_add'] = this.actorTimeAdd;
    data['actor_time_hits'] = this.actorTimeHits;
    data['actor_time_make'] = this.actorTimeMake;
    data['actor_hits'] = this.actorHits;
    data['actor_hits_day'] = this.actorHitsDay;
    data['actor_hits_week'] = this.actorHitsWeek;
    data['actor_hits_month'] = this.actorHitsMonth;
    data['actor_score'] = this.actorScore;
    data['actor_score_all'] = this.actorScoreAll;
    data['actor_score_num'] = this.actorScoreNum;
    data['actor_up'] = this.actorUp;
    data['actor_down'] = this.actorDown;
    data['actor_tpl'] = this.actorTpl;
    data['actor_jumpurl'] = this.actorJumpurl;
    data['actor_content'] = this.actorContent;
    data['type_name'] = this.typeName;
    return data;
  }
}
