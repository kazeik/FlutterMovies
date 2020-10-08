

## 项目地址：[https://github.com/shipinbaoku/FlutterMovies](https://github.com/shipinbaoku/FlutterMovies)
欢迎Star！给点动力！

## 多图杀猫，直接展示页面

![首页截图](https://img-blog.csdnimg.cn/20201008090515193.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![排行榜截图](https://img-blog.csdnimg.cn/20201008090547734.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)

![电影解说](https://img-blog.csdnimg.cn/20201008090603947.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![我的页面](https://img-blog.csdnimg.cn/20201008090633671.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![分类页截图](https://img-blog.csdnimg.cn/20201008090715218.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![视频详情页](https://img-blog.csdnimg.cn/20201008090735757.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![明星介绍页](https://img-blog.csdnimg.cn/20201008090754300.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)


![搜索页截图](https://img-blog.csdnimg.cn/2020100809121875.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)


![播放页截图一](https://img-blog.csdnimg.cn/20201008090820771.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)
![播放页截图二](https://img-blog.csdnimg.cn/20201008090846694.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)

## pubspec.yaml

```yaml
name: android
description: 今日看片客户端

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
version: 6.1.0+250000

environment:
  sdk: ">=2.2.2 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  #突破打印长度限制
  r_logger: ^0.1.2
  fluttertoast: ^4.0.1
  carousel_slider: ^1.4.1
  cached_network_image: 2.0.0
  transparent_image: ^1.0.0
  dio: ^3.0.9
  redux: ^4.0.0
  flutter_redux: ^0.6.0
  redux_persist: ^0.8.3
  redux_persist_flutter: ^0.8.2
  underline_indicator: ^0.0.2
  flutter_staggered_grid_view: ^0.3.0
  #flutter_webview_plugin: ^0.3.11
  palette_generator: ^0.2.3
  webview_flutter: ^0.3.21
  #x5_webview: ^0.2.2
  permission_handler: ^5.0.0
  common_utils: ^1.1.3
  rxdart: ^0.22.6
  fluintl: ^0.1.3
  flukit: ^1.0.2
  share: ^0.6.4+1
  url_launcher: ^5.4.5
  flutter_bugly: ^0.2.8
  flutter_tencentplayer: ^0.5.0
  screen: 0.0.5
  package_info: ^0.4.0+18
  #flutter_downloader: ^1.4.4
  launch_review: ^2.0.0
  flutter_forbidshot: 0.0.2
  path_provider: ^1.6.8
  flutter_launcher_icons: ^0.7.5
  tencent_ad: ^1.0.2+2
  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter_icons:
  android: "ic_launcher"
  ios: false
  image_path: "images/icon.png"
# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  assets:
   - images/
   - images/guide1.png
   - images/guide2.png
   - images/guide3.png
   - images/guide4.png
   - images/splash_bg.png
   - images/icon.png
   - images/tencentplayer/icon_back.png
   - images/tencentplayer/place_nodata.png
   - images/tencentplayer/player_lock.png
   - images/tencentplayer/player_pause.png
   - images/tencentplayer/player_play.png
   - images/tencentplayer/player_progress_img.png
   - images/tencentplayer/player_rotate.png
   - images/tencentplayer/player_unlock.png
   - images/tencentplayer/video_loading.png
   - images/tencentplayer/full_screen_on.png
  #  - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages

```


## 数据接口
详见lib/app/api_client.dart文件

 - [ ] 目前页面页面之间直接传值，这样显得很low，后续用状态管理完善
 - [ ] 目前收藏和观看记录存在本机，后续完善用户功能
 - [ ] 目前接口基于某个电影CMS改写的，后续换成自己的接口，支持更多功能



## 请作者来一根或者一包华子
![在这里插入图片描述](https://img-blog.csdnimg.cn/20201008093045719.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80MDA3NTk1Mg==,size_16,color_FFFFFF,t_70#pic_center)

