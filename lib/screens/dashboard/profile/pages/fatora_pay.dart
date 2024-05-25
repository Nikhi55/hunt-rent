import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FatoraPay extends StatefulWidget {
  final String currencyCode;
  final double amount;
  final String customerEmail;
  final String customerName;
  final String customerPhone;
  final String customerCountry;
  final String lang;
  final String note;

  FatoraPay({
    required this.currencyCode,
    required this.amount,
    required this.customerEmail,
    required this.customerName,
    required this.customerPhone,
    required this.customerCountry,
    required this.lang,
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  _FatoraPayState createState() => _FatoraPayState();
}

class _FatoraPayState extends State<FatoraPay> {
  final Completer<WebViewController> _webViewController =
      Completer<WebViewController>();
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    // Build the URL with query parameters
    // final String url =
    //     'https://fatora.hashnate.com?currencyCode=${widget.currencyCode}'
    //     '&amount=${widget.amount}'
    //     '&customerEmail=${widget.customerEmail}'
    //     '&customerName=${widget.customerName}'
    //     '&customerPhone=${widget.customerPhone}'
    //     '&customerCountry=${widget.customerCountry}'
    //     '&lang=${widget.lang}'
    //     '&note=${widget.note}';

    final String url =
        'https://fatora.hashnate.com?currencyCode=${widget.currencyCode}'
        '&amount=${widget.amount}'
        '&customerEmail=${widget.customerEmail}'
        '&customerName=${widget.customerName}'
        '&customerPhone=${widget.customerPhone}'
        '&customerCountry=${widget.customerCountry}'
        '&lang=${widget.lang}'
        '&note=${widget.note}';

    //webView Controller

    final WebViewController _webViewController;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(url)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Change your color here
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          "Fatora Payment",
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          WebViewWidget(controller: _webViewController),

          // WebView(
          //   initialUrl: url, // Use the modified URL with query parameters
          //   setjavascriptMode: JavaScriptMode.unrestricted,
          //   onWebViewCreated: (WebViewController webViewController) {
          //     _webViewController.complete(webViewController);
          //   },
          //   onPageStarted: (String url) {
          //     setState(() {
          //       _isLoading = true;
          //     });
          //   },
          //   onPageFinished: (String url) {
          //     setState(() {
          //       _isLoading = false;
          //     });
          //   },
          // ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Circular Progress Indicator
            ),
        ],
      ),
    );
  }
}
