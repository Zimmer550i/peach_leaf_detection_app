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
    var prediction = await Tflite.runModelOnImage(path: widget.image.path);

    setState(() {
      _output = prediction;
      _isLoading = false;
    });
  }

  loadmodel() async {
    await Tflite.loadModel(
        model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
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
        title: const Text("Peach Leaf Detection"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
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
            _isLoading ? const CircularProgressIndicator.adaptive() : details(),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }

  Column details() {
    return Column(
      children: [
        Text(
          _output![0]['label'].toString(),
          style: const TextStyle(
            color: Colors.purple,
            fontSize: 48,
            fontWeight: FontWeight.bold,
          ),
        ),
        for (int i = 0; i < _output!.length; i++)
          Text(
            "${_output![i]['label']} = ${_output![i]['confidence'].toString().substring(0, 5)}%",
            style: const TextStyle(
              fontFamily: "Segoe UI",
              fontSize: 28,
            ),
          ),
      ],
    );
  }
}
