// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:peach_leaf_detection_app/pages/detection.dart';

import '../utils/constants.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Peach Leaf Detection",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(),
            const Text(
              "Pick a Photo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () async {
                    final image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (image == null) {
                      Fluttertoast.showToast(
                          msg: "No Images have been Selected");
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetectionPage(
                            image: File(image.path),
                          ),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Lottie.asset(
                        "assets/upload.json",
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                      const Text(
                        "Upload A Photo",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: MediaQuery.of(context).size.width / 3,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(158, 158, 158, 0.3),
                  ),
                ),
                Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.camera);

                        if (image == null) {
                          Fluttertoast.showToast(
                              msg: "No Images have been Selected");
                        } else {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetectionPage(image: File(image.path)),
                            ),
                          );
                        }
                      },
                      child: Lottie.asset(
                        "assets/camera.json",
                        width: MediaQuery.of(context).size.width / 3,
                        height: MediaQuery.of(context).size.width / 3,
                      ),
                    ),
                    const Text(
                      "Take A Photo",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  width: double.infinity,
                  child: instructions(),
                ),
              ),
            ),
            const Text(
              "Developed By Zimemr550i",
              style: TextStyle(
                color: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column instructions() {
    return const Column(
      children: [
        Text(
          "\nInstructions\n",
          style: TextStyle(fontSize: 24),
        ),
        Text(
          instructionsText,
          textHeightBehavior: TextHeightBehavior(),
        ),
      ],
    );
  }
}
