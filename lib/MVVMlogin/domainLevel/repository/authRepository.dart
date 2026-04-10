import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/authApiDataProvider.dart';
import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/sessionDataP.dart';

//authService

class AuthRepository {
  final SessionKeyDataLevel _sessionKeyDataL = SessionKeyDataLevel();
  final AuthApiProvider _authApiProvider = AuthApiProvider();

  Future<bool> checkCurrentSessionAuth() async {
    final _apiKey = await _sessionKeyDataL.getDataApiKey();
    return _apiKey != null;
  }

  Future<void> logIn(String login, String password) async {
    final apiKey = await _authApiProvider.logInToNetworkApi(login, password);
    _sessionKeyDataL.saveDataApiKey(apiKey);
  }

  Future<void> logOut() async {
    await _sessionKeyDataL.clearDataApiKey();
  }
}
