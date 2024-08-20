// bindings.dart
import 'package:get/get.dart';
import 'package:nsc_whatidan_security/ui/auth_part/auth_repo.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticationRepository());
  }
}
