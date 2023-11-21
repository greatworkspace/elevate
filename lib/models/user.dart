class User {
  User({
    required this.id,
    required this.image,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.email,
    required this.identification,
    required this.kin,
    required this.marital,
    required this.account,
    required this.token,
    required this.deduction,
  });
  final int id;
  final String image;
  final String firstname;
  final String lastname;
  final String address;
  final String gender;
  final String nationality;
  final String phone;
  final String email;
  final String identification;
  final String kin;
  final String marital;
  final String account;
  final String token;
  final String deduction;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'token': token,
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'gender': gender,
      'nationality': nationality,
      'phone': phone,
      'email': email,
      'identification': identification,
      'kin': kin,
      'marital': marital,
      'account': account,
      'deduction':deduction,
    };
  }

  @override
  String toString() {
    return 'User{id: $id,image: $image, token $token, firstname: $firstname, lastname: $lastname, address: $address, gender: $gender, nationality: $nationality, phone:$phone, email:$email, identification:$identification, kin:$kin, marital:$marital, account: $account, deduction: $deduction';
  }
}
