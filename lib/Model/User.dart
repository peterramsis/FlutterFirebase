class UserModel
{
  String? name;
  String? address;
  String? phone;
  String? uid;
  String? email;
  String? cover;
  String? image;
  String? bio;


  UserModel.fromJson(Map<String , dynamic> json){
    uid     = json['uid'];
    name    = json['name'];
    address = json['address'];
    phone   = json['phone'];
    email   = json['email'];
    image   = json['image'];
    cover   = json['cover'];
    bio    = json['bio'];
  }


  UserModel(this.name, this.address, this.phone, this.uid, this.email , this.cover, this.image ,this.bio);

  Map<String, dynamic> toMap() {
    return {
      'name'    : name,
      'address' : address,
      'phone'   : phone,
      'uid'     : uid,
      "email"   : email,
      "cover"   : cover,
      "image"   : image,
      "bio"     : bio
    };
  }


}