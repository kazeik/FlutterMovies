class MovieTags{
  static List<String> getmoviesTags(String tags) {
    List tagsList =tags.split(',');
    return tagsList;
  }
}