import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:home_automation/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _controller;
  final TextEditingController _urlController = TextEditingController();
  bool isSearched = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  void _loadUrl() {
    String url = _urlController.text.trim();
    if (!url.startsWith("http")) {
      url = "https://$url";
    }
    setState(() {
      _controller.loadRequest(Uri.parse(url));
      isSearched=true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WebView App Assignment",
          style: TextStyle(fontWeight: FontWeight.w900, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: "Enter website URL",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurpleAccent,
                  onPressed: _loadUrl,
                  child: const Text(
                    "Go",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
          isSearched
              ? Expanded(
                  child: Stack(children: [
                  WebViewWidget(controller: _controller),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * 0.02,
                    left: 10,
                    child:SizedBox(height: 30,child: FloatingActionButton(
                      backgroundColor: Colors.deepPurpleAccent,
                      onPressed: () {
                        setState(() {
                          isSearched=false;
                          _urlController.text="";
                        });
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),)
                  ),
                ]))
              : Center(
                  child: Container(
                      child: Text(
                    "Enter URL in the above field",
                    style: TextStyle(color: Colors.black),
                    textAlign: TextAlign.center,)
                  ),
                )
        ],
      ),
    );
  }
}
