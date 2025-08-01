import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';

class CommonWebViewScreen extends StatefulWidget {
  final String url;
  const CommonWebViewScreen({super.key, required this.url});

  @override
  State<CommonWebViewScreen> createState() => _CommonWebViewScreenState();
}

class _CommonWebViewScreenState extends State<CommonWebViewScreen> {
  late InAppWebViewController webViewController;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await [
        Permission.camera,
        Permission.microphone,
        Permission.location,
        Permission.locationWhenInUse,
      ].request();
    } else {
      await [
        Permission.camera,
        Permission.microphone,
        Permission.location,
        Permission.locationWhenInUse,
        Permission.storage,
      ].request();
    }
  }

  // Method 1: Using JavaScript injection to trigger download
  Future<void> _handleDownloadWithJS(String url, String filename) async {
    try {
      // Inject JavaScript to create and trigger download
      await webViewController.evaluateJavascript(source: '''
        (function() {
          var link = document.createElement('a');
          link.href = '$url';
          link.download = '$filename';
          link.style.display = 'none';
          document.body.appendChild(link);
          link.click();
          document.body.removeChild(link);
        })();
      ''');

      _showSnackBar('Download started: $filename');
    } catch (e) {
      _showSnackBar('Download failed: ${e.toString()}');
    }
  }

  // Method 2: Using webview's built-in download with better error handling
  Future<void> _handleDownloadDirect(String url, String filename) async {
    try {
      Directory? directory;

      if (Platform.isAndroid) {
        // Try to get the public downloads directory first
        try {
          directory = Directory('/storage/emulated/0/Download');
          if (!await directory.exists()) {
            // Fallback to app's external directory
            final appDir = await getExternalStorageDirectory();
            if (appDir != null) {
              directory = Directory('${appDir.path}/Downloads');
              await directory.create(recursive: true);
            }
          }
        } catch (e) {
          // Final fallback to app documents
          directory = await getApplicationDocumentsDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        _showSnackBar('Could not access storage');
        return;
      }

      final filePath = '${directory.path}/$filename';

      // Get cookies and user agent from webview
      final cookies = await CookieManager.instance().getCookies(url: WebUri(url));
      final userAgent = await webViewController.getSettings().then((settings) => settings?.userAgent);

      // Create HTTP client with proper headers
      final client = HttpClient();
      try {
        final request = await client.getUrl(Uri.parse(url));

        // Add headers
        if (userAgent != null) {
          request.headers.set('User-Agent', userAgent);
        }
        request.headers.set('Accept', '*/*');

        // Add cookies
        if (cookies.isNotEmpty) {
          final cookieString = cookies.map((c) => '${c.name}=${c.value}').join('; ');
          request.headers.set('Cookie', cookieString);
        }

        final response = await request.close();

        if (response.statusCode == 200) {
          final file = File(filePath);
          final sink = file.openWrite();
          await response.pipe(sink);
          await sink.close();

          _showSnackBar('File saved to: ${directory.path}/$filename');
        } else {
          _showSnackBar('Download failed: HTTP ${response.statusCode}');
        }
      } finally {
        client.close();
      }
    } catch (e) {
      _showSnackBar('Download error: ${e.toString()}');
    }
  }

  // Method 3: Using Flutter's built-in download manager (Android only)
  Future<void> _handleDownloadAndroid(String url, String filename) async {
    if (!Platform.isAndroid) return;

    try {
      // Use Android's DownloadManager
      await webViewController.evaluateJavascript(source: '''
        (function() {
          var iframe = document.createElement('iframe');
          iframe.style.display = 'none';
          iframe.src = '$url';
          document.body.appendChild(iframe);
          setTimeout(function() {
            document.body.removeChild(iframe);
          }, 1000);
        })();
      ''');

      _showSnackBar('Download initiated through system manager');
    } catch (e) {
      _showSnackBar('System download failed: ${e.toString()}');
    }
  }

  // Method 4: Using data URL conversion
  Future<void> _handleDownloadDataURL(String url, String filename) async {
    try {
      // Convert to data URL and trigger download
      final jsCode = '''
        (async function() {
          try {
            const response = await fetch('$url');
            const blob = await response.blob();
            const dataUrl = await new Promise(resolve => {
              const reader = new FileReader();
              reader.onload = () => resolve(reader.result);
              reader.readAsDataURL(blob);
            });
            
            const link = document.createElement('a');
            link.href = dataUrl;
            link.download = '$filename';
            link.click();
            return 'success';
          } catch (error) {
            return 'error: ' + error.message;
          }
        })();
      ''';

      final result = await webViewController.evaluateJavascript(source: jsCode);
      if (result.toString().startsWith('error:')) {
        log(result.toString());

        _showSnackBar('Download failed: $result');
      } else {
        _showSnackBar('Download started: $filename');
      }
    } catch (e) {
      log(e.toString());

      _showSnackBar('Download error: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri.uri(Uri.parse(widget.url)),
            ),
            initialSettings: InAppWebViewSettings(
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              javaScriptEnabled: true,
              domStorageEnabled: true,
              useShouldOverrideUrlLoading: true,
              allowsBackForwardNavigationGestures: true,
              allowsAirPlayForMediaPlayback: true,

              mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
              hardwareAcceleration: true,
              clearCache: true,
              useOnDownloadStart: true,
              // Enable support for downloads
              supportMultipleWindows: true,
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
                errorMessage = null;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
            onReceivedError: (controller, request, error) {
              setState(() {
                isLoading = false;
                errorMessage = 'Error loading page: ${error.description}';
              });
            },
            onDownloadStartRequest: (controller, downloadStartRequest) async {
              String url = downloadStartRequest.url.toString();
              String filename = downloadStartRequest.suggestedFilename ??
                  url.split('/').last.split('?').first;

              if (!filename.toLowerCase().endsWith('.csv') &&
                  downloadStartRequest.mimeType?.contains('csv') == true) {
                filename = '${DateTime.now().toIso8601String()}.csv';
              }

              // Try multiple download methods in sequence
              _showSnackBar('Attempting download: $filename');

              // Method 1: Try JavaScript injection first
              await _handleDownloadWithJS(url, filename);

              // // If that fails, try direct download after a delay
              // Future.delayed(const Duration(seconds: 2), () async {
              //   await _handleDownloadDirect(url, filename);
              // });
              //
              // // For Android, also try system download manager
              // if (Platform.isAndroid) {
              //   Future.delayed(const Duration(seconds: 4), () async {
              //     await _handleDownloadAndroid(url, filename);
              //   });
              // }
              await _handleDownloadDataURL(url,filename);
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              bool cameraGranted = await Permission.camera.isGranted;
              bool microphoneGranted = await Permission.microphone.isGranted;
              bool locationGranted = await Permission.location.isGranted;

              List<String> grantedResources = [];

              for (String resource in resources) {
                if (resource == "android.webkit.resource.VIDEO_CAPTURE" && cameraGranted) {
                  grantedResources.add(resource);
                } else if (resource == "android.webkit.resource.AUDIO_CAPTURE" && microphoneGranted) {
                  grantedResources.add(resource);
                } else if (resource == "android.webkit.resource.GEOLOCATION" && locationGranted) {
                  grantedResources.add(resource);
                }
              }

              return PermissionRequestResponse(
                resources: grantedResources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
            onGeolocationPermissionsShowPrompt: (controller, origin) async {
              bool locationGranted = await Permission.location.isGranted;
              if (!locationGranted) {
                locationGranted = await Permission.location.request().isGranted;
              }

              return GeolocationPermissionShowPromptResponse(
                origin: origin,
                allow: locationGranted,
                retain: true,
              );
            },
          ),
          if (isLoading) const Center(child: CircularProgressIndicator()),
          if (errorMessage != null)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      webViewController.reload();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}