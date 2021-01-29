class User {
  String id;
  String email;
  String username;
  String status;
  int state;
  String profilePhoto;

  User({
    this.id,
    this.email,
    this.username,
    this.status,
    this.state,
    this.profilePhoto,
  });

  factory User.fromJson(Map<String, dynamic> doc) {
    return User(
        id: doc['id'],
        username: doc['username'],
        email: doc['email'],
        profilePhoto: doc['photoUrl'],
        status: doc["status"],
        state: doc["state"]);
  }
  User.fromMap(Map<String, dynamic> doc) {
    this.id = doc['id'];
    this.email = doc['email'];
    this.username = doc['username'];
    this.status = doc['status'];
    this.state = doc['state'];
    this.profilePhoto = doc['photoUrl'];
  }
}
