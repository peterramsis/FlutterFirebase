class UserModel
{
  String? name;
  String? address;
  String? phone;
  String? uid;
  String? email;


  UserModel.fromJson(Map<String , dynamic> json){
    uid     = json['uid'];
    name    = json['name'];
    address = json['address'];
    phone   = json['phone'];
    email   = json['email'];
  }


  UserModel(this.name, this.address, this.phone, this.uid, this.email);

  Map<String, dynamic> toMap() {
    return {
      'name'    : name,
      'address' : address,
      'phone'   : phone,
      'uid'     : uid,
      "email"   : email
    };
  }


}