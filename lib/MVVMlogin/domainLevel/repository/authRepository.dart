import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/authApiDataProvider.dart';
import 'package:architecture_training/MVVMlogin/domainLevel/dataProvider/sessionDataP.dart';

class AuthRepository {
  final SessionKeyDataLevel _sessionKeyDataL = SessionKeyDataLevel();
  final AuthApiProvider _authApiProvider = AuthApiProvider();
  Future<void> logIn(String login, String password) async {}
  Future<void> logOut() async {}
}
