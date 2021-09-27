class UserFromGoogle {
   UserFromGoogle({
        required this.id,
        required this.name,
        required this.givenName,
        required this.familyName,
        required this.picture,
        required this.locale,
    });

    String id;
    String name;
    String givenName;
    String familyName;
    String picture;
    String locale;

    factory UserFromGoogle.fromJson(Map<String, dynamic> json) => UserFromGoogle(
        id: json["id"],
        name: json["name"],
        givenName: json["given_name"],
        familyName: json["family_name"],
        picture: json["picture"],
        locale: json["locale"],
    );
}
