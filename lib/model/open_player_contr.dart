///本地播放器，来源控制开关

class PlayContr {
  bool open;

  PlayContr({this.open});

  PlayContr.fromJson(Map<String, dynamic> json) : open = json['open'];
}
