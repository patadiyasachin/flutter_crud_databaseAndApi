class ApiModel{
  String _name="";
  String _avatar="";

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String get avatar => _avatar;

  set avatar(String value) {
    _avatar = value;
  }

  Map<String,dynamic> mapConverter(){
    return{
      "name":name,
      "avatar":avatar
    };
  }
}