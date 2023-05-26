import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class DetectionPage extends StatefulWidget {
  final File image;
  const DetectionPage({required this.image, super.key});

  @override
  State<DetectionPage> createState() => _DetectionPageState();
}

class _DetectionPageState extends State<DetectionPage> {
  bool _isLoading = false;
  List? _output;

  detection() async {
    var prediction = await Tflite.runModelOnImage(
      path: widget.image.path,
      numResults: 2,
    );

    setState(() {
      _output = prediction;
      _isLoading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
      model: 'assets/model.tflite',
      labels: 'assets/labels.txt',
      numThreads: 2,
    );
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    loadmodel();
    detection();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Peach Leaf Detection",
          style: TextStyle(
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              child: Image.file(
                widget.image,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              width: double.infinity,
              height: 3,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(158, 158, 158, 0.3),
              ),
            ),
            _isLoading
                ? const CircularProgressIndicator.adaptive()
                : details(_output![0]['label'].toString() == "Healthy"),
            Expanded(
              child: Container(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Go Back"),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }

  Column details(bool healthy) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              healthy ? "Healthy Leaf" : "Bacterial Spots",
              maxLines: 1,
              style: const TextStyle(
                color: Colors.purple,
                fontSize: 100,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Text(
          healthy
              ? "No Bacterial Spot found in your Picture"
              : "Bacterial Spots found in your Picture",
        ),
        const Text("Confidence of each detection:"),
        for (int i = 0; i < _output!.length; i++)
          Text(
            "${_output![i]['label']} = ${_output![i]['confidence'].toString().substring(2, 4)}%",
            style: const TextStyle(
              fontFamily: "Segoe UI",
              fontSize: 14,
            ),
          ),
      ],
    );
  }
}
