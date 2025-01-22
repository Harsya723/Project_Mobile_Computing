import 'package:diary_app/controllers/category_controller.dart';
import 'package:diary_app/controllers/user_controller.dart';
import 'package:diary_app/pages/home/home_screen.dart';
import 'package:diary_app/utils/colours.dart';
import 'package:diary_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryController categoryController = Get.put(CategoryController());
  final UserController userController = Get.put(UserController());
  final Colours colours = Colours();
  final Fonts fonts = Fonts();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoryController.fetchCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // with dialog input form
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Tambah Kategori'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: categoryController.nameController,
                      decoration: InputDecoration(
                        hintText: 'Nama Kategori',
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Batal', style: TextStyle(color: colours.dark)),
                  ),
                  TextButton(
                    onPressed: () async {
                      await categoryController.createCategory();
                    },
                    child: Text('Simpan',
                        style: TextStyle(color: colours.primary)),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: colours.primary,
        child: Icon(Icons.add, color: colours.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60, left: 25, right: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Halo dan nama user dan di kanan itu button untuk logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: userController.getName(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          'Halo, ${snapshot.data!}!',
                          style: TextStyle(
                            color: colours.dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        );
                      } else {
                        return Text(
                          'Halo, User!',
                          style: TextStyle(
                            color: colours.dark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: fonts.bold,
                          ),
                        );
                      }
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const HomeScreen(),
                          transition: Transition.leftToRight);
                    },
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        color: colours.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: fonts.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // List diary
              Obx(() {
                if (categoryController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.only(top: 5),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: categoryController.categories.length,
                    itemBuilder: (context, index) {
                      final item = categoryController.categories[index];
                      return Card(
                        child: ListTile(
                          title: Text(item['name'],
                              style: TextStyle(
                                  color: colours.dark,
                                  fontFamily: fonts.semibold,
                                  fontSize: 15)),
                          trailing: GestureDetector(
                            child: Icon(Icons.delete_forever_outlined,
                                color: colours.danger),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Konfirmasi'),
                                    content: Text(
                                        'Apakah anda yakin ingin menghapus kategori ${item['name']} ini?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('Batal',
                                            style:
                                                TextStyle(color: colours.dark)),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                            await categoryController
                                                .deleteCategory(item['id'].toString());
                                        },
                                        child: Text('Hapus',
                                            style: TextStyle(
                                                color: colours.danger)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          onTap: () {
                            // with dialog input form
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Edit Kategori'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller:
                                            categoryController.nameController =
                                                TextEditingController(
                                                    text: item['name']),
                                        decoration: InputDecoration(
                                          hintText: 'Nama Kategori',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Batal',
                                          style:
                                              TextStyle(color: colours.dark)),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await categoryController.updateCategory(
                                            item['id'].toString());
                                      },
                                      child: Text('Simpan',
                                          style: TextStyle(
                                              color: colours.primary)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
