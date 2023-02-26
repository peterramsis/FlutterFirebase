
class MessageModel{

  String? dateTime;
  String? text;
  String? receiverId;
  String? senderId;

  MessageModel.fromJson(Map<String , dynamic> json){

    dateTime    = json["dateTime"];
    text        = json["text"];
    senderId    = json["senderId"];
    receiverId  = json["receiverId"];
  }
  MessageModel( {this.dateTime, this.text  , this.senderId, this.receiverId});

  Map<String, dynamic> toMap() {
    return {

      "dateTime"   : dateTime,
      "text"       : text,
      "receiverId" : receiverId,
      "senderId" : senderId

    };
  }
}