class MovieDetailMac {
  int vodId;
  int typeId;
  int typeId1;
  int groupId;
  String vodName;
  String vodSub;
  String vodEn;
  int vodStatus;
  String vodLetter;
  String vodColor;
  String vodTag;
  String vodClass;
  String vodPic;
  String vodPicThumb;
  String vodPicSlide;
  String vodActor;
  String vodDirector;
  String vodWriter;
  String vodBehind;
  String vodBlurb;
  String vodRemarks;
  String vodPubdate;
  int vodTotal;
  String vodSerial;
  String vodTv;
  String vodWeekday;
  String vodArea;
  String vodLang;
  String vodYear;
  String vodVersion;
  String vodState;
  String vodAuthor;
  String vodJumpurl;
  String vodTpl;
  String vodTplPlay;
  String vodTplDown;
  int vodIsend;
  int vodLock;
  int vodLevel;
  int vodCopyright;
  int vodPoints;
  int vodPointsPlay;
  int vodPointsDown;
  int vodHits;
  int vodHitsDay;
  int vodHitsWeek;
  int vodHitsMonth;
  String vodDuration;
  int vodUp;
  int vodDown;
  String vodScore;
  int vodScoreAll;
  int vodScoreNum;
  int vodTime;
  int vodTimeAdd;
  int vodTimeHits;
  int vodTimeMake;
  int vodTrysee;
  int vodDoubanId;
  String vodDoubanScore;
  String vodReurl;
  String vodRelVod;
  String vodRelArt;
  String vodPwd;
  String vodPwdUrl;
  String vodPwdPlay;
  String vodPwdPlayUrl;
  String vodPwdDown;
  String vodPwdDownUrl;
  String vodContent;
  String vodPlayFrom;
  String vodPlayServer;
  String vodPlayNote;
  String vodPlayUrl;
  String vodDownFrom;
  String vodDownServer;
  String vodDownNote;
  String vodDownUrl;
  int vodPlot;
  String vodPlotName;
  String vodPlotDetail;
  List<VodPlayList> vodDownList;
  List<VodPlayList> vodPlayList;

  MovieDetailMac(
      {this.vodId,
        this.typeId,
        this.typeId1,
        this.groupId,
        this.vodName,
        this.vodSub,
        this.vodEn,
        this.vodStatus,
        this.vodLetter,
        this.vodColor,
        this.vodTag,
        this.vodClass,
        this.vodPic,
        this.vodPicThumb,
        this.vodPicSlide,
        this.vodActor,
        this.vodDirector,
        this.vodWriter,
        this.vodBehind,
        this.vodBlurb,
        this.vodRemarks,
        this.vodPubdate,
        this.vodTotal,
        this.vodSerial,
        this.vodTv,
        this.vodWeekday,
        this.vodArea,
        this.vodLang,
        this.vodYear,
        this.vodVersion,
        this.vodState,
        this.vodAuthor,
        this.vodJumpurl,
        this.vodTpl,
        this.vodTplPlay,
        this.vodTplDown,
        this.vodIsend,
        this.vodLock,
        this.vodLevel,
        this.vodCopyright,
        this.vodPoints,
        this.vodPointsPlay,
        this.vodPointsDown,
        this.vodHits,
        this.vodHitsDay,
        this.vodHitsWeek,
        this.vodHitsMonth,
        this.vodDuration,
        this.vodUp,
        this.vodDown,
        this.vodScore,
        this.vodScoreAll,
        this.vodScoreNum,
        this.vodTime,
        this.vodTimeAdd,
        this.vodTimeHits,
        this.vodTimeMake,
        this.vodTrysee,
        this.vodDoubanId,
        this.vodDoubanScore,
        this.vodReurl,
        this.vodRelVod,
        this.vodRelArt,
        this.vodPwd,
        this.vodPwdUrl,
        this.vodPwdPlay,
        this.vodPwdPlayUrl,
        this.vodPwdDown,
        this.vodPwdDownUrl,
        this.vodContent,
        this.vodPlayFrom,
        this.vodPlayServer,
        this.vodPlayNote,
        this.vodPlayUrl,
        this.vodDownFrom,
        this.vodDownServer,
        this.vodDownNote,
        this.vodDownUrl,
        this.vodPlot,
        this.vodPlotName,
        this.vodPlotDetail,
        this.vodDownList,
        this.vodPlayList});


  MovieDetailMac.fromJson(Map<String, dynamic> json) {
    vodId = json['vod_id'];
    typeId = json['type_id'];
    typeId1 = json['type_id_1'];
    groupId = json['group_id'];
    vodName = json['vod_name'];
    vodSub = json['vod_sub'];
    vodEn = json['vod_en'];
    vodStatus = json['vod_status'];
    vodLetter = json['vod_letter'];
    vodColor = json['vod_color'];
    vodTag = json['vod_tag'];
    vodClass = json['vod_class'];
    vodPic = json['vod_pic'];
    vodPicThumb = json['vod_pic_thumb'];
    vodPicSlide = json['vod_pic_slide'];
    vodActor = json['vod_actor'];
    vodDirector = json['vod_director'];
    vodWriter = json['vod_writer'];
    vodBehind = json['vod_behind'];
    vodBlurb = json['vod_blurb'];
    vodRemarks = json['vod_remarks'];
    vodPubdate = json['vod_pubdate'];
    vodTotal = json['vod_total'];
    vodSerial = json['vod_serial'];
    vodTv = json['vod_tv'];
    vodWeekday = json['vod_weekday'];
    vodArea = json['vod_area'];
    vodLang = json['vod_lang'];
    vodYear = json['vod_year'];
    vodVersion = json['vod_version'];
    vodState = json['vod_state'];
    vodAuthor = json['vod_author'];
    vodJumpurl = json['vod_jumpurl'];
    vodTpl = json['vod_tpl'];
    vodTplPlay = json['vod_tpl_play'];
    vodTplDown = json['vod_tpl_down'];
    vodIsend = json['vod_isend'];
    vodLock = json['vod_lock'];
    vodLevel = json['vod_level'];
    vodCopyright = json['vod_copyright'];
    vodPoints = json['vod_points'];
    vodPointsPlay = json['vod_points_play'];
    vodPointsDown = json['vod_points_down'];
    vodHits = json['vod_hits'];
    vodHitsDay = json['vod_hits_day'];
    vodHitsWeek = json['vod_hits_week'];
    vodHitsMonth = json['vod_hits_month'];
    vodDuration = json['vod_duration'];
    vodUp = json['vod_up'];
    vodDown = json['vod_down'];
    vodScore = json['vod_score'];
    vodScoreAll = json['vod_score_all'];
    vodScoreNum = json['vod_score_num'];
    vodTime = json['vod_time'];
    vodTimeAdd = json['vod_time_add'];
    vodTimeHits = json['vod_time_hits'];
    vodTimeMake = json['vod_time_make'];
    vodTrysee = json['vod_trysee'];
    vodDoubanId = json['vod_douban_id'];
    vodDoubanScore = json['vod_douban_score'];
    vodReurl = json['vod_reurl'];
    vodRelVod = json['vod_rel_vod'];
    vodRelArt = json['vod_rel_art'];
    vodPwd = json['vod_pwd'];
    vodPwdUrl = json['vod_pwd_url'];
    vodPwdPlay = json['vod_pwd_play'];
    vodPwdPlayUrl = json['vod_pwd_play_url'];
    vodPwdDown = json['vod_pwd_down'];
    vodPwdDownUrl = json['vod_pwd_down_url'];
    vodContent = json['vod_content'];
    vodPlayFrom = json['vod_play_from'];
    vodPlayServer = json['vod_play_server'];
    vodPlayNote = json['vod_play_note'];
    vodPlayUrl = json['vod_play_url'];
    vodDownFrom = json['vod_down_from'];
    vodDownServer = json['vod_down_server'];
    vodDownNote = json['vod_down_note'];
    vodDownUrl = json['vod_down_url'];
    vodPlot = json['vod_plot'];
    vodPlotName = json['vod_plot_name'];
    vodPlotDetail = json['vod_plot_detail'];
    if (json['vod_down_list'] != null) {
      vodDownList = new List<VodPlayList>();
      json['vod_down_list'].forEach((v) {
        vodDownList.add(new VodPlayList.fromJson(v));
      });
    }
    if (json['vod_play_list'] != null) {
      vodPlayList = new List<VodPlayList>();
      json['vod_play_list'].forEach((v) {
        vodPlayList.add(new VodPlayList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vod_id'] = this.vodId;
    data['type_id'] = this.typeId;
    data['type_id_1'] = this.typeId1;
    data['group_id'] = this.groupId;
    data['vod_name'] = this.vodName;
    data['vod_sub'] = this.vodSub;
    data['vod_en'] = this.vodEn;
    data['vod_status'] = this.vodStatus;
    data['vod_letter'] = this.vodLetter;
    data['vod_color'] = this.vodColor;
    data['vod_tag'] = this.vodTag;
    data['vod_class'] = this.vodClass;
    data['vod_pic'] = this.vodPic;
    data['vod_pic_thumb'] = this.vodPicThumb;
    data['vod_pic_slide'] = this.vodPicSlide;
    data['vod_actor'] = this.vodActor;
    data['vod_director'] = this.vodDirector;
    data['vod_writer'] = this.vodWriter;
    data['vod_behind'] = this.vodBehind;
    data['vod_blurb'] = this.vodBlurb;
    data['vod_remarks'] = this.vodRemarks;
    data['vod_pubdate'] = this.vodPubdate;
    data['vod_total'] = this.vodTotal;
    data['vod_serial'] = this.vodSerial;
    data['vod_tv'] = this.vodTv;
    data['vod_weekday'] = this.vodWeekday;
    data['vod_area'] = this.vodArea;
    data['vod_lang'] = this.vodLang;
    data['vod_year'] = this.vodYear;
    data['vod_version'] = this.vodVersion;
    data['vod_state'] = this.vodState;
    data['vod_author'] = this.vodAuthor;
    data['vod_jumpurl'] = this.vodJumpurl;
    data['vod_tpl'] = this.vodTpl;
    data['vod_tpl_play'] = this.vodTplPlay;
    data['vod_tpl_down'] = this.vodTplDown;
    data['vod_isend'] = this.vodIsend;
    data['vod_lock'] = this.vodLock;
    data['vod_level'] = this.vodLevel;
    data['vod_copyright'] = this.vodCopyright;
    data['vod_points'] = this.vodPoints;
    data['vod_points_play'] = this.vodPointsPlay;
    data['vod_points_down'] = this.vodPointsDown;
    data['vod_hits'] = this.vodHits;
    data['vod_hits_day'] = this.vodHitsDay;
    data['vod_hits_week'] = this.vodHitsWeek;
    data['vod_hits_month'] = this.vodHitsMonth;
    data['vod_duration'] = this.vodDuration;
    data['vod_up'] = this.vodUp;
    data['vod_down'] = this.vodDown;
    data['vod_score'] = this.vodScore;
    data['vod_score_all'] = this.vodScoreAll;
    data['vod_score_num'] = this.vodScoreNum;
    data['vod_time'] = this.vodTime;
    data['vod_time_add'] = this.vodTimeAdd;
    data['vod_time_hits'] = this.vodTimeHits;
    data['vod_time_make'] = this.vodTimeMake;
    data['vod_trysee'] = this.vodTrysee;
    data['vod_douban_id'] = this.vodDoubanId;
    data['vod_douban_score'] = this.vodDoubanScore;
    data['vod_reurl'] = this.vodReurl;
    data['vod_rel_vod'] = this.vodRelVod;
    data['vod_rel_art'] = this.vodRelArt;
    data['vod_pwd'] = this.vodPwd;
    data['vod_pwd_url'] = this.vodPwdUrl;
    data['vod_pwd_play'] = this.vodPwdPlay;
    data['vod_pwd_play_url'] = this.vodPwdPlayUrl;
    data['vod_pwd_down'] = this.vodPwdDown;
    data['vod_pwd_down_url'] = this.vodPwdDownUrl;
    data['vod_content'] = this.vodContent;
    data['vod_play_from'] = this.vodPlayFrom;
    data['vod_play_server'] = this.vodPlayServer;
    data['vod_play_note'] = this.vodPlayNote;
    data['vod_play_url'] = this.vodPlayUrl;
    data['vod_down_from'] = this.vodDownFrom;
    data['vod_down_server'] = this.vodDownServer;
    data['vod_down_note'] = this.vodDownNote;
    data['vod_down_url'] = this.vodDownUrl;
    data['vod_plot'] = this.vodPlot;
    data['vod_plot_name'] = this.vodPlotName;
    data['vod_plot_detail'] = this.vodPlotDetail;
    if (this.vodDownList != null) {
      data['vod_down_list'] = this.vodDownList.map((v) => v.toJson()).toList();
    }
    if (this.vodPlayList != null) {
      data['vod_play_list'] = this.vodPlayList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
/*class VodDownList {
  int sid;
  PlayerInfo playerInfo;
  Null serverInfo;
  String from;
  String url;
  String server;
 // Null note;
  int urlCount;
  List<Urls> urls;

  VodDownList(
      {this.sid,
        this.playerInfo,
        this.serverInfo,
        this.from,
        this.url,
        this.server,
        //this.note,
        this.urlCount,
        this.urls});

  VodDownList.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    playerInfo = json['player_info'] != null
        ? new PlayerInfo.fromJson(json['player_info'])
        : null;
    serverInfo = json['server_info'];
    from = json['from'];
    url = json['url'];
    server = json['server'];
    //note = json['note'];
    urlCount = json['url_count'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {
        urls.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    if (this.playerInfo != null) {
      data['player_info'] = this.playerInfo.toJson();
    }
    data['server_info'] = this.serverInfo;
    data['from'] = this.from;
    data['url'] = this.url;
    data['server'] = this.server;
    //data['note'] = this.note;
    data['url_count'] = this.urlCount;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}*/
class VodPlayList {
  int sid;
  PlayerInfo playerInfo;
  Null serverInfo;
  String from;
  String url;
  String server;
  String note;
  int urlCount;
  List<Urls> urls;

  VodPlayList(
      {this.sid,
        this.playerInfo,
        this.serverInfo,
        this.from,
        this.url,
        this.server,
        this.note,
        this.urlCount,
        this.urls});

  VodPlayList.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    playerInfo = json['player_info'] != null
        ? new PlayerInfo.fromJson(json['player_info'])
        : null;
    serverInfo = json['server_info'];
    from = json['from'];
    url = json['url'];
    server = json['server'];
    note = json['note'];
    urlCount = json['url_count'];
    if (json['urls'] != null) {
      urls = new List<Urls>();
      json['urls'].forEach((v) {


        urls.add(new Urls.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    if (this.playerInfo != null) {
      data['player_info'] = this.playerInfo.toJson();
    }
    data['server_info'] = this.serverInfo;
    data['from'] = this.from;
    data['url'] = this.url;
    data['server'] = this.server;
    data['note'] = this.note;
    data['url_count'] = this.urlCount;
    if (this.urls != null) {
      data['urls'] = this.urls.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayerInfo {
  String status;
  String copyrightUrl;
  String from;
  String show;
  String des;
  String target;
  String ps;
  String parse;
  String sort;
  String tip;
  String id;

  PlayerInfo(
      {this.status,
        this.copyrightUrl,
        this.from,
        this.show,
        this.des,
        this.target,
        this.ps,
        this.parse,
        this.sort,
        this.tip,
        this.id});

  PlayerInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    copyrightUrl = json['copyright_url'];
    from = json['from'];
    show = json['show'];
    des = json['des'];
    target = json['target'];
    ps = json['ps'];
    parse = json['parse'];
    sort = json['sort'];
    tip = json['tip'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['copyright_url'] = this.copyrightUrl;
    data['from'] = this.from;
    data['show'] = this.show;
    data['des'] = this.des;
    data['target'] = this.target;
    data['ps'] = this.ps;
    data['parse'] = this.parse;
    data['sort'] = this.sort;
    data['tip'] = this.tip;
    data['id'] = this.id;
    return data;
  }
}

class Urls {
  String name;
  String url;
  String from;
  int nid;

  Urls({this.name, this.url, this.from, this.nid});

  Urls.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
    from = json['from'];
    nid = json['nid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    data['from'] = this.from;
    data['nid'] = this.nid;
    return data;
  }
}
