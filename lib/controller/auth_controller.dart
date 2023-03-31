import 'package:curiosity_app/common/repositories/auth_repository.dart';

import '../models/user_model.dart';

class AuthController {
  AuthRepository authRepository = AuthRepository();

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  void setUserState(bool isOnline) {
    return authRepository.setUserState(isOnline);
  }
}
