class Comment {
  String commentid, content, image, name, time, id;
  List replyes;
  Comment(this.commentid, this.content, this.image, this.name, this.time,
      this.id, this.replyes);
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json["_id"],
      json["comment"],
      json["image"],
      json["commentator"]["local"]["username"],
      json["comment_date"],
      json["_id"],
      json["replies"],
    );
  }
}
