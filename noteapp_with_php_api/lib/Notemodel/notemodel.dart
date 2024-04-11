class NoteModel {
  int? notosId;
  String? notosTitle;
  String? notosContent;
  String? notosImage;
  int? notosUser;

  NoteModel(
      {this.notosId,
      this.notosTitle,
      this.notosContent,
      this.notosImage,
      this.notosUser});

  NoteModel.fromJson(Map<String, dynamic> json) {
    notosId = json['notos_id'];
    notosTitle = json['notos_title'];
    notosContent = json['notos_content'];
    notosImage = json['notos_image'];
    notosUser = json['notos_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notos_id'] = this.notosId;
    data['notos_title'] = this.notosTitle;
    data['notos_content'] = this.notosContent;
    data['notos_image'] = this.notosImage;
    data['notos_user'] = this.notosUser;
    return data;
  }
}