class UserModel {
 late final String sId;
 late final String displayName;
 late final String username;
 late final List<String> roles;
 late final bool active;
 late final int experienceYears;
 late final String address;
 late final String level;
 late final String createdAt;
 late final String updatedAt;
 late final int iV;


 UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id']??'';
    displayName = json['displayName']??'';
    username = json['username']??'';
    roles = json['roles'].cast<String>()??[];
    active = json['active']??'';
    experienceYears = json['experienceYears']??'';
    address = json['address']??'';
    level = json['level']??'';
    createdAt = json['createdAt']??'';
    updatedAt = json['updatedAt']??'';
    iV = json['__v']??'';
  }
}
