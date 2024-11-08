

import '../models/user.dart';

abstract  class AuthenticationRepository { //existe una sesion abierta, la obtenemos
  Future <bool> get isSignedIn;
  Future<User?>getUserData();
}