class User{

   final int id;
   final String userName;
   final String fistName;
   final String lastName;
   final String email;


  const User({required this.id, required this.userName, required this.fistName, required this.lastName, required this.email,
      });

   factory User.fromjson(Map<String,dynamic> json){
      return User(
        id: json['id'],
        userName:json['username'],
        fistName: json['fistmame'],
        lastName: json['lastname'],
        email: json['email'],


      );
   }
}