class News {
  String title, content, image, tag, name, time, id;
  News(this.title, this.content, this.image, this.tag, this.name, this.time,
      this.id);
  factory News.fromJson(Map<String, dynamic> json) {
    return News(json["title"], json["content"], json["image"], json["tag_name"],
        json["userId"]["local"]["username"], json["created_at"], json["_id"]);
  }
}
