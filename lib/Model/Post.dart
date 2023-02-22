
class Post{
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;

  Post.fromJson(Map<String , dynamic> json){
    uid       = json['uid'];
    name      = json['name'];
    image     = json['image'];
    dateTime  = json["dateTime"];
    text      = json["text"];
    postImage = json["postImage"];
  }
  Post( {this.uid,this.image , this.name ,this.dateTime, this.text ,this.postImage});

  Map<String, dynamic> toMap() {
    return {
      'name'       : name,
      'uid'        : uid,
      "image"      : image,
      "dateTime"   : dateTime,
      "text"       : text,
      "postImage" : postImage
    };
  }
}