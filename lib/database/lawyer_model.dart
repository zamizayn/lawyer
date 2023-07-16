class LawyerModel {
  late String lawyerMastrName;
  late String lawyerMastrPhone1;
  late String lawyerMastrEmail;
  late String lawyerMastrCity;
  late String lawyerMastrType;
  dynamic lawyerMastrAge;
  String? lawyerMastrProfilePic;
  late String cmnStateName;
  late String cmnCountryName;
  dynamic lawyerMastrExperience;
  String? lawyerMastrDescription;
  dynamic lawyerMastrWorkEnv;
  late String lawyerMastrToken;

  LawyerModel(
      {required this.lawyerMastrName,
      required this.lawyerMastrPhone1,
      required this.lawyerMastrEmail,
      required this.lawyerMastrCity,
      required this.lawyerMastrType,
      required this.lawyerMastrAge,
      required this.lawyerMastrProfilePic,
      required this.cmnStateName,
      required this.cmnCountryName,
      required this.lawyerMastrExperience,
      required this.lawyerMastrDescription,
      required this.lawyerMastrWorkEnv,
      required this.lawyerMastrToken});

  LawyerModel.fromJson(Map<String, dynamic> json) {
    lawyerMastrName = json['lawyer_mastr_name'];
    lawyerMastrPhone1 = json['lawyer_mastr_phone1'];
    lawyerMastrEmail = json['lawyer_mastr_email'];
    lawyerMastrCity = json['lawyer_mastr_city'];
    lawyerMastrType = json['lawyer_mastr_type'];
    lawyerMastrAge = json['lawyer_mastr_age'];
    lawyerMastrProfilePic = json['lawyer_mastr_profile_pic'];
    cmnStateName = json['cmn_state_name'];
    cmnCountryName = json['cmn_country_name'];
    lawyerMastrExperience = json['lawyer_mastr_experience'];
    lawyerMastrDescription = json['lawyer_mastr_description'];
    lawyerMastrWorkEnv = json['lawyer_mastr_work_env'];
    lawyerMastrToken = json['lawyer_mastr_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lawyer_mastr_name'] = lawyerMastrName;
    data['lawyer_mastr_phone1'] = lawyerMastrPhone1;
    data['lawyer_mastr_email'] = lawyerMastrEmail;
    data['lawyer_mastr_city'] = lawyerMastrCity;
    data['lawyer_mastr_type'] = lawyerMastrType;
    data['lawyer_mastr_age'] = lawyerMastrAge;
    data['lawyer_mastr_profile_pic'] = lawyerMastrProfilePic;
    data['cmn_state_name'] = cmnStateName;
    data['cmn_country_name'] = cmnCountryName;
    data['lawyer_mastr_experience'] = lawyerMastrExperience;
    data['lawyer_mastr_description'] = lawyerMastrDescription;
    data['lawyer_mastr_work_env'] = lawyerMastrWorkEnv;
    data['lawyer_mastr_token'] = lawyerMastrToken;
    return data;
  }
}
