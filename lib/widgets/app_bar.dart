part of 'widgets.dart';

class AppBarCustom extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function()? navigator;
  final Color? backgroundColor;
  final Color? textColor;

  AppBarCustom({
    required this.title,
    this.subTitle,
    this.navigator,
    this.backgroundColor,
    this.textColor,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        color: backgroundColor ?? Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: navigator ??
                    () {
                      Get.off(const LoginPage());
                    },
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child:
                      Icon(Icons.arrow_back, color: textColor ?? Colors.black),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: nunitoTextFont.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
