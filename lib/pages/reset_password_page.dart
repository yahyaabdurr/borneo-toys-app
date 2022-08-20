part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final GlobalKey<FormState> formKey;
  bool isLoading = false;
  bool isHidePassword = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    void reset() async {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((result) async {
        isLoading = false;

        await GlobalFuntion.alert(
            context: context,
            message: "Reset Password Berhasil, Silahkan cek email Anda",
            titleButton: "OK",
            onTap: () async {
              Get.offAll(const LoginPage());
            });
      }).catchError((err) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar("Terjadi Kesalahan", err.toString());
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("Reset Password Akun Borneo Toys",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: nunitoTextFont.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4F5262))),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: greyWhiteColor,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: 'Masukan email Anda',
                              hintStyle: GoogleFonts.nunitoSans()
                                  .copyWith(color: Colors.grey, fontSize: 12),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Email Address';
                              } else if (!GetUtils.isEmail(value)) {
                                return 'Please enter a valid email address!';
                              }
                              return null;
                            }),
                        Container(
                          margin: const EdgeInsets.only(top: 30),
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (formKey.currentState?.validate() ?? false) {
                                setState(() {
                                  isLoading = true;
                                });
                                reset();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: isLoading
                                  ? MaterialStateProperty.all(
                                      greyBackgroundColor)
                                  : MaterialStateProperty.all(primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                ),
                              ),
                            ),
                            child: isLoading
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                        color: primaryColor),
                                  )
                                : Text(
                                    "Reset Password",
                                    style: nunitoTextFont.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
