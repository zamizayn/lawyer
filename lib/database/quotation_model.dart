class QuotationModel {
  late int pkQuotesId;
  late int quotesAdvanceAmount;
  late String quotesComment;
  late String quotesUpdatedDate;
  late String quotesCretnDate;
  late String quoteStatsFlg;
  late Quoteslawyer quoteslawyer;
  late QuoteRequest quoteRequest;

  QuotationModel(
      {required this.pkQuotesId,
      required this.quotesAdvanceAmount,
      required this.quotesComment,
      required this.quotesUpdatedDate,
      required this.quotesCretnDate,
      required this.quoteStatsFlg,
      required this.quoteslawyer,
      required this.quoteRequest});

  QuotationModel.fromJson(Map<String, dynamic> json) {
    pkQuotesId = json['pk_quotes_id'];
    quotesAdvanceAmount = json['quotes_advance_amount'];
    quotesComment = json['quotes_comment'];
    quotesUpdatedDate = json['quotes_updated_date'];
    quotesCretnDate = json['quotes_cretn_date'];
    quoteStatsFlg = json['quote_stats_flg'];
    quoteslawyer = Quoteslawyer.fromJson(json['quoteslawyer']);
    quoteRequest = QuoteRequest.fromJson(json['quote_request']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pk_quotes_id'] = pkQuotesId;
    data['quotes_advance_amount'] = quotesAdvanceAmount;
    data['quotes_comment'] = quotesComment;
    data['quotes_updated_date'] = quotesUpdatedDate;
    data['quotes_cretn_date'] = quotesCretnDate;
    data['quote_stats_flg'] = quoteStatsFlg;
    if (quoteslawyer != dynamic) {
      data['quoteslawyer'] = quoteslawyer.toJson();
    }
    data['quote_request'] = quoteRequest.toJson();
    return data;
  }
}

class Quoteslawyer {
  late String lawyerMastrName;
  late String lawyerMastrType;
  late dynamic lawyerMastrPhone3;
  late dynamic lawyerMastrPhone2;
  late String lawyerMastrPhone1;
  late String lawyerMastrEmail;
  late dynamic lawyerMastrDescription;
  late String lawyerMastrStatsFlg;
  late String lawyerMastrDelFlg;
  late dynamic lawyerMastrWatsapp;
  late dynamic lawyerMastrInsta;
  late dynamic lawyerMastrFb;
  late int fkLawyerMastrCountryId;
  late int fkLawyerMastrStateId;
  late dynamic lawyerMastrAge;
  late dynamic lawyerMastrPassportPic;
  late String lawyerMastrCity;
  late dynamic lawyerMastrExperience;
  late dynamic lawyerMastrWorkEnv;
  late dynamic lawyerMastrProfilePic;
  late String lawyerMastrDob;
  late String lawyerMastrAddress;
  late String lawyerMastrPostal;
  late String lawyerMastrCretnDate;
  late String lawyerMastrUpdatedDate;
  late String lawyerMastrToken;
  late dynamic lawyerMastrLawFirmName;
  late dynamic lawyerMastrLawFirmAddress;
  late dynamic lawyerMastrSpecialization;
  late dynamic lawyerMastrBarAssociationMembership;
  late dynamic lawyerMastrYearsOfExp;
  late dynamic lawyerMastrEducation;
  late dynamic lawyerMastrLanguageKnown;
  late dynamic lawyerMastrAboutMe;

  Quoteslawyer(
      {required this.lawyerMastrName,
      required this.lawyerMastrType,
      required this.lawyerMastrPhone3,
      required this.lawyerMastrPhone2,
      required this.lawyerMastrPhone1,
      required this.lawyerMastrEmail,
      required this.lawyerMastrDescription,
      required this.lawyerMastrStatsFlg,
      required this.lawyerMastrDelFlg,
      required this.lawyerMastrWatsapp,
      required this.lawyerMastrInsta,
      required this.lawyerMastrFb,
      required this.fkLawyerMastrCountryId,
      required this.fkLawyerMastrStateId,
      required this.lawyerMastrAge,
      required this.lawyerMastrPassportPic,
      required this.lawyerMastrCity,
      required this.lawyerMastrExperience,
      required this.lawyerMastrWorkEnv,
      required this.lawyerMastrProfilePic,
      required this.lawyerMastrDob,
      required this.lawyerMastrAddress,
      required this.lawyerMastrPostal,
      required this.lawyerMastrCretnDate,
      required this.lawyerMastrUpdatedDate,
      required this.lawyerMastrToken,
      required this.lawyerMastrLawFirmName,
      required this.lawyerMastrLawFirmAddress,
      required this.lawyerMastrSpecialization,
      required this.lawyerMastrBarAssociationMembership,
      required this.lawyerMastrYearsOfExp,
      required this.lawyerMastrEducation,
      required this.lawyerMastrLanguageKnown,
      required this.lawyerMastrAboutMe});

  Quoteslawyer.fromJson(Map<String, dynamic> json) {
    lawyerMastrName = json['lawyer_mastr_name'];
    lawyerMastrType = json['lawyer_mastr_type'];
    lawyerMastrPhone3 = json['lawyer_mastr_phone3'];
    lawyerMastrPhone2 = json['lawyer_mastr_phone2'];
    lawyerMastrPhone1 = json['lawyer_mastr_phone1'];
    lawyerMastrEmail = json['lawyer_mastr_email'];
    lawyerMastrDescription = json['lawyer_mastr_description'];
    lawyerMastrStatsFlg = json['lawyer_mastr_stats_flg'];
    lawyerMastrDelFlg = json['lawyer_mastr_del_flg'];
    lawyerMastrWatsapp = json['lawyer_mastr_watsapp'];
    lawyerMastrInsta = json['lawyer_mastr_insta'];
    lawyerMastrFb = json['lawyer_mastr_fb'];
    fkLawyerMastrCountryId = json['fk_lawyer_mastr_country_id'];
    fkLawyerMastrStateId = json['fk_lawyer_mastr_state_id'];
    lawyerMastrAge = json['lawyer_mastr_age'];
    lawyerMastrPassportPic = json['lawyer_mastr_passport_pic'];
    lawyerMastrCity = json['lawyer_mastr_city'];
    lawyerMastrExperience = json['lawyer_mastr_experience'];
    lawyerMastrWorkEnv = json['lawyer_mastr_work_env'];
    lawyerMastrProfilePic = json['lawyer_mastr_profile_pic'];
    lawyerMastrDob = json['lawyer_mastr_dob'];
    lawyerMastrAddress = json['lawyer_mastr_address'];
    lawyerMastrPostal = json['lawyer_mastr_postal'];
    lawyerMastrCretnDate = json['lawyer_mastr_cretn_date'];
    lawyerMastrUpdatedDate = json['lawyer_mastr_updated_date'];
    lawyerMastrToken = json['lawyer_mastr_token'];
    lawyerMastrLawFirmName = json['lawyer_mastr_law_firm_name'];
    lawyerMastrLawFirmAddress = json['lawyer_mastr_law_firm_address'];
    lawyerMastrSpecialization = json['lawyer_mastr_specialization'];
    lawyerMastrBarAssociationMembership = json['lawyer_mastr_bar_association_membership'];
    lawyerMastrYearsOfExp = json['lawyer_mastr_years_of_exp'];
    lawyerMastrEducation = json['lawyer_mastr_education'];
    lawyerMastrLanguageKnown = json['lawyer_mastr_language_known'];
    lawyerMastrAboutMe = json['lawyer_mastr_about_me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lawyer_mastr_name'] = lawyerMastrName;
    data['lawyer_mastr_type'] = lawyerMastrType;
    data['lawyer_mastr_phone3'] = lawyerMastrPhone3;
    data['lawyer_mastr_phone2'] = lawyerMastrPhone2;
    data['lawyer_mastr_phone1'] = lawyerMastrPhone1;
    data['lawyer_mastr_email'] = lawyerMastrEmail;
    data['lawyer_mastr_description'] = lawyerMastrDescription;
    data['lawyer_mastr_stats_flg'] = lawyerMastrStatsFlg;
    data['lawyer_mastr_del_flg'] = lawyerMastrDelFlg;
    data['lawyer_mastr_watsapp'] = lawyerMastrWatsapp;
    data['lawyer_mastr_insta'] = lawyerMastrInsta;
    data['lawyer_mastr_fb'] = lawyerMastrFb;
    data['fk_lawyer_mastr_country_id'] = fkLawyerMastrCountryId;
    data['fk_lawyer_mastr_state_id'] = fkLawyerMastrStateId;
    data['lawyer_mastr_age'] = lawyerMastrAge;
    data['lawyer_mastr_passport_pic'] = lawyerMastrPassportPic;
    data['lawyer_mastr_city'] = lawyerMastrCity;
    data['lawyer_mastr_experience'] = lawyerMastrExperience;
    data['lawyer_mastr_work_env'] = lawyerMastrWorkEnv;
    data['lawyer_mastr_profile_pic'] = lawyerMastrProfilePic;
    data['lawyer_mastr_dob'] = lawyerMastrDob;
    data['lawyer_mastr_address'] = lawyerMastrAddress;
    data['lawyer_mastr_postal'] = lawyerMastrPostal;
    data['lawyer_mastr_cretn_date'] = lawyerMastrCretnDate;
    data['lawyer_mastr_updated_date'] = lawyerMastrUpdatedDate;
    data['lawyer_mastr_token'] = lawyerMastrToken;
    data['lawyer_mastr_law_firm_name'] = lawyerMastrLawFirmName;
    data['lawyer_mastr_law_firm_address'] = lawyerMastrLawFirmAddress;
    data['lawyer_mastr_specialization'] = lawyerMastrSpecialization;
    data['lawyer_mastr_bar_association_membership'] = lawyerMastrBarAssociationMembership;
    data['lawyer_mastr_years_of_exp'] = lawyerMastrYearsOfExp;
    data['lawyer_mastr_education'] = lawyerMastrEducation;
    data['lawyer_mastr_language_known'] = lawyerMastrLanguageKnown;
    data['lawyer_mastr_about_me'] = lawyerMastrAboutMe;
    return data;
  }
}

class QuoteRequest {
  late int pkUserRequestId;
  late int fkUserMastrRequestQuoteId;
  late String requestDescription;
  late String requestAttachment;
  late String? requestStatsFlg;
  late String? requestDelFlg;
  late dynamic requestCreatedBy;
  late String? requestCreatnDate;
  late dynamic requestUpdatedBy;
  late String? requestUpdatedDate;
  late String? requestTitle;
  late String? requestPublicId;

  QuoteRequest(
      {required this.pkUserRequestId,
      required this.fkUserMastrRequestQuoteId,
      required this.requestDescription,
      required this.requestAttachment,
      required this.requestStatsFlg,
      required this.requestDelFlg,
      required this.requestCreatedBy,
      required this.requestCreatnDate,
      required this.requestUpdatedBy,
      required this.requestUpdatedDate,
      required this.requestTitle,
      required this.requestPublicId});

  QuoteRequest.fromJson(Map<String, dynamic> json) {
    pkUserRequestId = json['pk_user_request_id'];
    fkUserMastrRequestQuoteId = json['fk_user_mastr_request_quote_id'];
    requestDescription = json['request_description'] ?? "";
    requestAttachment = json['request_attachment'];
    requestStatsFlg = json['request_stats_flg'];
    requestDelFlg = json['request_del_flg'];
    requestCreatedBy = json['request_created_by'];
    requestCreatnDate = json['request_creatn_date'];
    requestUpdatedBy = json['request_updated_by'];
    requestUpdatedDate = json['request_updated_date'];
    requestTitle = json['request_title'];
    requestPublicId = json['request_public_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pk_user_request_id'] = pkUserRequestId;
    data['fk_user_mastr_request_quote_id'] = fkUserMastrRequestQuoteId;
    data['request_description'] = requestDescription;
    data['request_attachment'] = requestAttachment;
    data['request_stats_flg'] = requestStatsFlg;
    data['request_del_flg'] = requestDelFlg;
    data['request_created_by'] = requestCreatedBy;
    data['request_creatn_date'] = requestCreatnDate;
    data['request_updated_by'] = requestUpdatedBy;
    data['request_updated_date'] = requestUpdatedDate;
    data['request_title'] = requestTitle;
    data['request_public_id'] = requestPublicId;
    return data;
  }
}
