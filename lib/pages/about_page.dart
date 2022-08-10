part of 'pages.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Tentang Aplikasi"),
        titleTextStyle: nunitoTextFont.copyWith(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        backgroundColor: primaryColor,
        leading: GestureDetector(
          onTap: () {
            Get.offAll(const LoginPage());
          },
          child: const SizedBox(
            height: 24,
            width: 24,
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Aplikasi ini dibuat untuk \n pelayanan dibidang kasir",
                  maxLines: 2,
                  style: nunitoTextFont.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Dibimbing Oleh \n Wanvy Arifha Saputra, M.Kom \n Drs. Koes Wiyatmoko, M.kom",
                  maxLines: 3,
                  style: nunitoTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Dirancang Oleh \n Ahmad Surya Putra \n Ibnu Alfiannor Fikri",
                  maxLines: 3,
                  style: nunitoTextFont.copyWith(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Borneo Toys \n JL.Tol Trikora Jalan Samping Pasar Peramuan Ruko 4 Pintu, Landasan Ulin Bar., Kec. Liang Anggang, Kota Banjar Baru, Kalimantan Selatan 70724",
                  style: nunitoTextFont.copyWith(
                    fontSize: 20,
                  ),
                ),
              ),
            ])),
      ),
    );
  }
}
