part of 'controllers.dart';

// class AuthController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   RxBool isSuccess = false.obs;
//   // CollectionReference users = FirebaseFirestore.instance.collection('users');

//   late TextEditingController emailController, passwordController;
//   var email = '';
//   var password = '';
//   @override
//   void onInit() {
//     super.onInit();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//   }

//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//   }

//   String? validateEmail(String value) {
//     if (value.isEmpty) {
//       return "Tidak Boleh Kosong.";
//     } else {
//       if (!GetUtils.isEmail(value)) {
//         return "Format email salah";
//       }
//     }

//     return null;
//   }

//   void login() async {
//     try {
//       Get.off(const HomePage());
//       // UserCredential result = await _auth.createUserWithEmailAndPassword(
//       //     email: emailController.text, password: passwordController.text);
//       // if (result.user != null) {
//       //   Get.off(const HomePage());
//       // } else {
//       //   Get.snackbar("Input Salah", "Input Salah");
//       // }
//     } catch (e) {
//       Get.snackbar("Terjadi Kesalahan", e.toString());
//     }
//   }
// }
