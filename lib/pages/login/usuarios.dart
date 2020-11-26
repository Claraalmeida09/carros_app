class Usuario{
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  Usuario.fromJson(Map<String, dynamic> map):
    login = map['login'],
    nome = map['nome'],
    email = map['email'],
    token = map['token'],
    roles =  map['roles'] != null ? map['roles'].map<String>((role) => role.toString()).toList() : null;



  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, toke: $token}';
  }

  static List<String> getRoles(Map<String, dynamic> map) {
    List<String> roles = map['roles'].map<String>((role) => role.toString()).toList();
    return roles;
  }
}