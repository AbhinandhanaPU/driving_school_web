// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeacherModel {
  String? docid;
  String? password;
  String? teacheremail;
  String? teacherName;
  String? phoneNumber;
  String? dateofBirth;
  String? guardianName;
  String? address;
  String? place;
  String? profileImageId;
  String? profileImageUrl;
  String? rtoName;
  String? licenceNumber;
  String? joiningDate;
  String userRole;

  TeacherModel({
    this.docid,
    this.password,
    this.teacheremail,
    this.teacherName,
    this.phoneNumber,
    this.dateofBirth,
    this.guardianName,
    this.address,
    this.place,
    this.profileImageId,
    this.profileImageUrl,
    this.rtoName,
    this.licenceNumber,
    this.joiningDate,
    this.userRole = 'teacher',
  });

  TeacherModel copyWith({
    String? docid,
    String? password,
    String? teacheremail,
    String? teacherName,
    String? phoneNumber,
    String? dateofBirth,
    String? guardianName,
    String? address,
    String? place,
    String? profileImageId,
    String? profileImageUrl,
    String? rtoName,
    String? licenceNumber,
    String? joiningDate,
    String? userRole,
  }) {
    return TeacherModel(
      docid: docid ?? this.docid,
      password: password ?? this.password,
      teacheremail: teacheremail ?? this.teacheremail,
      teacherName: teacherName ?? this.teacherName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateofBirth: dateofBirth ?? this.dateofBirth,
      guardianName: guardianName ?? this.guardianName,
      address: address ?? this.address,
      place: place ?? this.place,
      profileImageId: profileImageId ?? this.profileImageId,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rtoName: rtoName ?? this.rtoName,
      licenceNumber: licenceNumber ?? this.licenceNumber,
      joiningDate: joiningDate ?? this.joiningDate,
      userRole: userRole ?? this.userRole,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'docid': docid,
      'password': password,
      'teacheremail': teacheremail,
      'teacherName': teacherName,
      'phoneNumber': phoneNumber,
      'dateofBirth': dateofBirth,
      'guardianName': guardianName,
      'address': address,
      'place': place,
      'profileImageId': profileImageId,
      'profileImageUrl': profileImageUrl,
      'rtoName': rtoName,
      'licenceNumber': licenceNumber,
      'joiningDate': joiningDate,
      'userRole': userRole,
    };
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) {
    return TeacherModel(
      docid: map['docid'] != null ? map['docid'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      teacheremail:
          map['teacheremail'] != null ? map['teacheremail'] as String : null,
      teacherName:
          map['teacherName'] != null ? map['teacherName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      dateofBirth:
          map['dateofBirth'] != null ? map['dateofBirth'] as String : null,
      guardianName:
          map['guardianName'] != null ? map['guardianName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      place: map['place'] != null ? map['place'] as String : null,
      profileImageId: map['profileImageId'] != null
          ? map['profileImageId'] as String
          : null,
      profileImageUrl: map['profileImageUrl'] != null
          ? map['profileImageUrl'] as String
          : null,
      rtoName: map['rtoName'] != null ? map['rtoName'] as String : null,
      licenceNumber:
          map['licenceNumber'] != null ? map['licenceNumber'] as String : null,
      joiningDate:
          map['joiningDate'] != null ? map['joiningDate'] as String : null,
      userRole: map['userRole'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherModel.fromJson(String source) =>
      TeacherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeacherModel(docid: $docid, password: $password, teacheremail: $teacheremail, teacherName: $teacherName, phoneNumber: $phoneNumber, dateofBirth: $dateofBirth, guardianName: $guardianName, address: $address, place: $place, profileImageId: $profileImageId, profileImageUrl: $profileImageUrl, rtoName: $rtoName, licenceNumber: $licenceNumber, joiningDate: $joiningDate, userRole: $userRole)';
  }

  @override
  bool operator ==(covariant TeacherModel other) {
    if (identical(this, other)) return true;

    return other.docid == docid &&
        other.password == password &&
        other.teacheremail == teacheremail &&
        other.teacherName == teacherName &&
        other.phoneNumber == phoneNumber &&
        other.dateofBirth == dateofBirth &&
        other.guardianName == guardianName &&
        other.address == address &&
        other.place == place &&
        other.profileImageId == profileImageId &&
        other.profileImageUrl == profileImageUrl &&
        other.rtoName == rtoName &&
        other.licenceNumber == licenceNumber &&
        other.joiningDate == joiningDate &&
        other.userRole == userRole;
  }

  @override
  int get hashCode {
    return docid.hashCode ^
        password.hashCode ^
        teacheremail.hashCode ^
        teacherName.hashCode ^
        phoneNumber.hashCode ^
        dateofBirth.hashCode ^
        guardianName.hashCode ^
        address.hashCode ^
        place.hashCode ^
        profileImageId.hashCode ^
        profileImageUrl.hashCode ^
        rtoName.hashCode ^
        licenceNumber.hashCode ^
        joiningDate.hashCode ^
        userRole.hashCode;
  }
}
