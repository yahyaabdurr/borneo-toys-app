part of 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    void login() async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((result) async {
        isLoading = false;
        Get.off(const HomePage());

        await storage.write(key: "isAlreadyLogin", value: "true");
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(const AboutPage());
                      },
                      child: Text("Tentang Aplikasi",
                          style: nunitoTextFont.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: blueColor,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: Text("Point of Sales Toko Borneo of Toys",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: nunitoTextFont.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF4F5262))),
                ),
                const SizedBox(
                  height: 50,
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
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: isHidePassword,
                        decoration: InputDecoration(
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 2,
                            minHeight: 2,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidePassword = !isHidePassword;
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Icon(
                                  isHidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: blueColor),
                            ),
                          ),
                          filled: true,
                          fillColor: greyWhiteColor,
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Masukan password Anda',
                          hintStyle: GoogleFonts.nunitoSans()
                              .copyWith(color: Colors.grey, fontSize: 12),
                        ),
                        validator: (String? value) {
                          if (value?.isEmpty ?? false) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
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
                              login();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: isLoading
                                ? MaterialStateProperty.all(greyBackgroundColor)
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
                                  "Masuk",
                                  style: nunitoTextFont.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          "Lupa Password ?",
                          style: nunitoTextFont.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
