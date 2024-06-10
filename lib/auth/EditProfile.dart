class ProfileModel {
  String? name;
  String? Doj;
  String? Dob;
  String? age;
  String? gender;
  String? marital_status;
  String? photo_proof;
  String? Education;
  String? Email;
  String? Mobile_no;
  String? alternative_mobile_no;
  String? password;
  String? confirm_password;
  String? professional;
  String? professional_details;
  String? Select_id;
  String? current_address;
  String? pincode;
  String? district;
  String? State;
  String? country;
  String? Permanent_address;
  String? per_pincode;
  String? per_district;
  String? per_State;
  String? per_country;
  String? income;
  String? Experience;
  String? professionalValue;
  String? idprofValue;
  String? districtValue;
  String? stateValue;
  String? dropdownValueGender;
  String? dropdownValueMarital;
  String? perdistrictValue;
  String? perstateValue;

  ProfileModel(
      this.name,
      this.Doj,
      this.Dob,
      this.age,
      this.gender,
      this.marital_status,
      this.photo_proof,
      this.Education,
      this.Email,
      this.Mobile_no,
      this.alternative_mobile_no,
      this.password,
      this.confirm_password,
      this.professional,
      this.professional_details,
      this.Select_id,
      this.current_address,
      this.pincode,
      this.district,
      this.State,
      this.country,
      this.Permanent_address,
      this.per_pincode,
      this.per_district,
      this.per_State,
      this.per_country,
      this.income,
      this.Experience,
      this.professionalValue,
      this.idprofValue,
      this.stateValue,
      this.dropdownValueGender,
      this.dropdownValueMarital,
      this.perdistrictValue,
      this.perstateValue);

  ProfileModel.fromJson(dynamic json) {
    name = json['name'];
    Doj = json['join_date'];
    Dob = json['dob'];
    age = json['age'];
    gender = json['gender'];
    Mobile_no = json['whatsapp_no'];
    alternative_mobile_no = json['alter_mobileno'];
    Email = json['email'];
    marital_status = json['maried_status'];
    password = json['password'];
    pincode = json['cur_pincode'];
    current_address = json['cur_address'];
    State = json['cur_state'];
    district = json['cur_district'];
    country = json['cur_country'];
    per_State = json['per_state'];
    per_district = json['per_district'];
    per_country = json['per_country'];
    Permanent_address = json['per_address'];
    Education = json['qualification'];
    professional = json['professional'];
    professional_details = json['professional_deatils'];
    Experience = json['job_experience'];
    per_pincode = json['per_pincode'];
    photo_proof = json['photo'];
  }

  Map<String, dynamic> toMap(ProfileModel value) => {
        'name': value.name,
        'join_date': value.Doj,
        'dob': value.Dob,
        'age': value.age,
        'gender': value.gender,
        'whatsapp_no': value.Mobile_no,
        'alter_mobileno': value.alternative_mobile_no,
        'email': value.Email,
        'maried_status': value.marital_status,
        'password': value.password,
        'cur_pincode': value.pincode,
        'cur_state': value.State,
      };
}
