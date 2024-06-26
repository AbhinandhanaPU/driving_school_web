// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AdminLoginDetailHistoryModel {
  String adminID;
  String adminName;
  String docid;
  String loginTime;
  String logoutTime;

  AdminLoginDetailHistoryModel({
    required this.adminID,
    required this.adminName,
    required this.docid,
    required this.loginTime,
    required this.logoutTime,
  });

  AdminLoginDetailHistoryModel copyWith({
    String? adminID,
    String? adminName,
    String? docid,
    String? loginTime,
    String? logoutTime,
  }) {
    return AdminLoginDetailHistoryModel(
      adminID: docid ?? this.adminID,
      adminName: adminName ?? this.adminName,
      docid: docid ?? this.docid,
      loginTime: loginTime ?? this.loginTime,
      logoutTime: logoutTime ?? this.logoutTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'adminID': adminID,
      'adminName': adminName,
      'docid': docid,
      'loginTime': loginTime,
      'logoutTime': logoutTime,
    };
  }

  factory AdminLoginDetailHistoryModel.fromMap(Map<String, dynamic> map) {
    return AdminLoginDetailHistoryModel(
      adminID: map['adminID'] ?? '',
      adminName: map['adminName'] ?? '',
      docid: map['docid'] ?? '',
      loginTime: map['loginTime'] ?? '',
      logoutTime: map['logoutTime'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AdminLoginDetailHistoryModel.fromJson(String source) =>
      AdminLoginDetailHistoryModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AdminLoginDetailHistoryModel(adminID: $adminID, adminName: $adminName, docid: $docid, loginTime: $loginTime, logoutTime: $logoutTime)';
  }

  @override
  bool operator ==(covariant AdminLoginDetailHistoryModel other) {
    if (identical(this, other)) return true;

    return other.adminID == adminID &&
        other.adminName == adminName &&
        other.docid == docid &&
        other.loginTime == loginTime &&
        other.logoutTime == logoutTime;
  }

  @override
  int get hashCode {
    return adminID.hashCode ^
        adminName.hashCode ^
        docid.hashCode ^
        loginTime.hashCode ^
        logoutTime.hashCode;
  }
}

class LoginTimeIDSavingClass {
  static String id = '';
  static String date = '';
  static String emailId = '';
}
