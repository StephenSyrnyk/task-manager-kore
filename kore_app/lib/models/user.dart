class User {
  int id;
  String email;
  String name;
  String iconFileUrl;
  String iconFileId;
  String lastLogin;
  String dateCreated;
  int status;
  String firstName;
  String lastName;
  String sid;

  User({
    this.id,
    this.email,
    this.name, 
    this.iconFileUrl,
    this.iconFileId,
    this.lastLogin,
    this.dateCreated, 
    this.status,
    this.firstName,
    this.lastName,
    this.sid
    });

factory User.fromJson(Map<String, dynamic> json ) {
    return new User(
        id: json['id'] as int,
        email: json['email'] as String,
        name: json['name'] as String,
        iconFileUrl: json['iconFileUrl'] as String,
        iconFileId: json['iconFileId'] as String,
        lastLogin: json['lastLogin'] as String,
        dateCreated: json['dateCreated'] as String,
        status: json['status'] as int,
        firstName: json['firstName'] as String,
        lastName: json['LastName'] as String,
        sid: json['sid'] as String,
    );
  }

}