class News {
  String title, content, image, tag, time, id;
  List likedby;
  List commets;

  News(this.title, this.content, this.image, this.tag, this.time, this.id,
      this.likedby, this.commets);
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        json["title"],
        json["content"],
        json["image"],
        json["tag_name"],
        // json["userId"]["local"]["username"],
        json["created_at"],
        json["_id"],
        json['likedBy'].toList(),
        json['comments'].toList());
  }
}
