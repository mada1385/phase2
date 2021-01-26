class Comment {
  String commentid, content, image, name, time, id;
  List replyes, likedby;
  Comment(this.commentid, this.content, this.image, this.name, this.time,
      this.id, this.replyes, this.likedby);
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      json["_id"],
      json["comment"],
      json["commentator"]["image"],
      json["commentator"]["local"]["username"],
      json["comment_date"],
      json["_id"],
      json["replies"].map((dynamic item) => Reply.fromJson(item)).toList(),
      json['likedBy'].toList(),
    );
  }
}

class Reply {
  String replyid, content, image, name, time, id;
  Reply(this.replyid, this.content, this.image, this.name, this.time, this.id);
  factory Reply.fromJson(Map<String, dynamic> json) {
    return Reply(
      json["_id"],
      json["reply"],
      json["replier"]["image"],
      json["replier"]["local"]["username"],
      json["comment_date"],
      json["_id"],
    );
  }
}
