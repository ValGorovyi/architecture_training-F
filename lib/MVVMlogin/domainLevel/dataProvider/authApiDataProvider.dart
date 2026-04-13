//this fake demo api client

abstract class AuthApiProviderError {
  // static const
}

class AuthIcorerectDataError {}

class AuthApiProvider {
  Future<String> logInToNetworkApi(String login, String password) async {
    await Future<void>.delayed(Duration(seconds: 1));
    final isSuccesLogIn = login == 'admin' && password == '12345';
    if (isSuccesLogIn) {
      return 'myFakeApiKey';
    } else {
      throw AuthIcorerectDataError();
    }
  }
}
