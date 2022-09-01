part of 'pages.dart';

class CategorySearchPage extends StatefulWidget {
  const CategorySearchPage({Key? key}) : super(key: key);

  @override
  State<CategorySearchPage> createState() => _CategorySearchPageState();
}

class _CategorySearchPageState extends State<CategorySearchPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Provider.of<CategoryController>(context, listen: false).initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer<CategoryController>(builder: (context, provider, _) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              title: const Text("Category Product"),
              titleTextStyle: nunitoTextFont.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const SizedBox(
                  height: 24,
                  width: 24,
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              flexibleSpace: Container(
                margin: const EdgeInsets.fromLTRB(10, 50, 10, 10),
                height: 45,
                child: TextField(
                  onChanged: (value) {
                    provider.searchData();
                  },
                  controller: provider.searchQuery,
                  keyboardType: TextInputType.text,
                  textAlignVertical: TextAlignVertical.bottom,
                  decoration: InputDecoration(
                      focusColor: primaryColor,
                      hintText: 'Cari Category Product',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      suffixIcon: const Icon(Icons.search)),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder(
                  future: provider.categoryList,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Category>> snapshot) {
                    if (snapshot.hasData &&
                        (snapshot.data?.isNotEmpty ?? false)) {
                      return ListView.separated(
                          shrinkWrap: true,
                          itemCount: provider.retrievedCategorysList.length,
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Get.offAll(const ProductPage(),
                                    arguments:
                                        provider.retrievedCategorysList[index]);
                              },
                              leading: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Image(
                                  image: AssetImage(
                                      'assets/images/borneo_logo.jpeg'),
                                ),
                              ),
                              title: Text(provider
                                  .retrievedCategorysList[index].categoryDesc),
                            );
                          });
                    } else if (snapshot.connectionState ==
                            ConnectionState.done &&
                        provider.retrievedCategorysList.isEmpty) {
                      return Center(
                        child: ListView(
                          children: const <Widget>[
                            Align(
                                alignment: AlignmentDirectional.center,
                                child: Text('No data available')),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
