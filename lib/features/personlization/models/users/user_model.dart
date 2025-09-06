import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? id;
  String? phoneNumber;
  String? userName;
  String profilePicture;

  UserModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.userName,
      this.id,
      this.profilePicture = ''});

  String get fullName => '$firstName $lastName';
  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      phoneNumber: '',
      profilePicture: '',
      email: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Email': email
    };
  }

  static List<String> nameParts(fullName) => fullName.split(" ");

  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";
    String camelCaseUsername = "$firstName$lastName";
    String usernameWithPrefix = "bro_$camelCaseUsername";
    return usernameWithPrefix;
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return UserModel(
        id: document.id,
        firstName: data['FirstName'],
        lastName: data['LastName'],
        email: data['Email'],
        phoneNumber: data['PhoneNumber'],
        profilePicture: data['ProfilePicture'],
      );
    }
    return UserModel.empty();
  }
}
