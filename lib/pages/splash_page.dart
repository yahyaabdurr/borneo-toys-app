part of 'pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();

    loadUserInfo();
  }

  loadUserInfo() async {
    bool isAlreadyLogin =
        (await storage.read(key: "isAlreadyLogin") ?? "") == "true";

    Timer(
        const Duration(seconds: 3),
        () => isAlreadyLogin
            ? Get.offAll(const HomePage())
            : Get.offAll(const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: const Center(
          child: SizedBox(
              height: 400,
              child: Image(
                image: AssetImage('assets/images/borneo_logo.jpeg'),
              )),
        ));
  }
}
