class AuthRepository {
  Future<void> login(userName, password) async {
    if (userName == 'admin123' && password == 'admin123') {
      print('attempting login');
      await Future.delayed(Duration(seconds: 3));
      print('logged in');
    } else {
      throw Exception('failed log in');
    }
  }

  Future<void> signup() async {
    print('attempting login');
    await Future.delayed(Duration(seconds: 3));
    print('logged in');
    throw Exception('failed log in');
  }
}
