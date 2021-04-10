class BestComment {
  int id;
  int userId;
  int feedbackId;
  int answerCommentId;
  String text;
  String createdAt;
  String updatedAt;
  int likesCount;

  BestComment({
    this.id,
    this.userId,
    this.feedbackId,
    this.answerCommentId,
    this.text,
    this.createdAt,
    this.updatedAt,
    this.likesCount,
  });

  BestComment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    feedbackId = json['feedback_id'];
    answerCommentId = json['answer_comment_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    likesCount = json['likes_count'];
  }

  static List<BestComment> fromJsonList(json) {
    List<BestComment> list = [];
    for (var item in json) {
      list.add(BestComment.fromJson(item));
    }
    return list;
  }
}
