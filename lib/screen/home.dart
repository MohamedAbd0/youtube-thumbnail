import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_thumbnail/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? selectedDomainValue = "img.youtube.com";
  final List<String> itemsDomains = [
    'img.youtube.com',
    'i.ytimg.com',
    'i3.ytimg.com',
  ];

  late NameID selectedThumbnailsValue;

  List<NameID> thumbnails = [
    NameID(name: "Full-size Image", id: "0.jpg"),
    NameID(name: "Thumbnail Frame 1", id: "1.jpg"),
    NameID(name: "Thumbnail Frame 2", id: "2.jpg"),
    NameID(name: "Thumbnail Frame 3", id: "3.jpg"),
    NameID(name: "Default Thumbnail", id: "default.jpg"),
    NameID(name: "High Quality Thumbnail", id: "hqdefault.jpg"),
    NameID(name: "Medium Quality Thumbnail", id: "mqdefault.jpg"),
    NameID(name: "Standard Definition Thumbnail", id: "sddefault.jpg"),
    NameID(name: "Maximum Resolution Thumbnail", id: "maxresdefault.jpg"),
    NameID(name: "Alternate High Quality Thumbnail 2", id: "hq2.jpg"),
    NameID(name: "Alternate High Quality Thumbnail 3", id: "hq3.jpg"),
    NameID(name: "Alternate Maximum Resolution Thumbnail 2", id: "maxres2.jpg"),
  ];

  String? thumbnailUrl;
  String? videoID;

  @override
  void initState() {
    super.initState();
    selectedThumbnailsValue = thumbnails[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.15,
          vertical: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: Column(
              children: [
                const Text(
                  "To Easily Retrieve YouTube Video Thumbnail Images",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: ResponsiveLayout.isMobile(context) ? 50.w : 200.w,
                      child: Assets.images.imLogo.image(),
                    ),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          children: [
                            TextSpan(
                              text:
                                  'You can use the following formats for YouTube video links to retrieve the thumbnail:\n\n',
                              style: TextStyle(fontSize: 18),
                            ),
                            TextSpan(
                              text: '- ',
                            ),
                            TextSpan(
                              text:
                                  'https://www.youtube.com/watch?v=VIDEO_ID\n',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: '- ',
                            ),
                            TextSpan(
                              text: 'https://youtu.be/VIDEO_ID\n',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: '- ',
                            ),
                            TextSpan(
                              text: 'https://www.youtube.com/embed/VIDEO_ID\n',
                              style: TextStyle(color: Colors.blue),
                            ),
                            TextSpan(
                              text: '- ',
                            ),
                            TextSpan(
                              text:
                                  'https://www.youtube.com/watch?v=VIDEO_ID&t=60s',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  validator: (value) {
                    if (isValidYouTubeUrl(value ?? "")) {
                      return null;
                    } else {
                      return 'Invalid YouTube Video URL';
                    }
                  },
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    labelText: 'Enter YouTube Video URL',
                    border: const OutlineInputBorder(),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Set the background color here
                          foregroundColor:
                              Colors.white, // Set the text color here
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12), // Optional padding
                          shape: RoundedRectangleBorder(
                            // Optional: to customize the button shape
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            videoID =
                                extractVideoId(_textEditingController.text);
                            generateThumbnailUrl();
                          }
                        },
                        child: const Text(
                          'Generate',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedDomainValue,
                        decoration: const InputDecoration(
                          labelText: 'Select Domain', // Label like a TextField
                          border: OutlineInputBorder(), // Add a border
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: itemsDomains.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDomainValue = newValue;
                          });
                          generateThumbnailUrl();
                        },
                        isExpanded: true, // Makes the dropdown full width
                      ),
                    ),
                    const SizedBox(width: 20), // Space between dropdowns
                    Expanded(
                      child: DropdownButtonFormField<NameID>(
                        value: selectedThumbnailsValue,
                        decoration: const InputDecoration(
                          labelText: 'Select Resolution',
                          border: OutlineInputBorder(), // Add a border
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: thumbnails.map((NameID value) {
                          return DropdownMenuItem<NameID>(
                            value: value,
                            child: Text(value.name),
                          );
                        }).toList(),
                        onChanged: (NameID? newValue) {
                          setState(() {
                            selectedThumbnailsValue =
                                newValue ?? thumbnails.first;
                          });
                          generateThumbnailUrl();
                        },
                        isExpanded: true, // Makes the dropdown full width
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (thumbnailUrl != null) ...[
                  Image.network(
                    "https://us-central1-tube-thumbnail.cloudfunctions.net/app/proxy?imagePath=$thumbnailUrl",
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        );
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.error,
                      ); // Placeholder for error case
                    },
                  ),
                  const SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black87),
                    ),
                    child: ListTile(
                      title: SelectableText(thumbnailUrl ?? ""),
                      trailing: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: thumbnailUrl ?? ""))
                              .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  thumbnailUrl ?? "",
                                ),
                              ),
                            );
                          });
                        },
                        icon: const Icon(
                          Icons.copy,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  void generateThumbnailUrl() {
    if (selectedDomainValue == null || videoID == null) {
      // Show an error message if either domain or resolution is not selected
      return;
    }

    // Construct the URL based on the selected domain and resolution
    setState(() {
      thumbnailUrl =
          'https://$selectedDomainValue/vi/$videoID/${selectedThumbnailsValue.id}';
    });
  }

  bool isValidYouTubeUrl(String url) {
    late final Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return false;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return false;
    }
    // youtube.com/watch?v=xxxxxxxxxxx
    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        (uri.pathSegments.first == 'watch' ||
            uri.pathSegments.first == 'live')) {
      return true;
    }
    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      return true;
    }
    // www.youtube.com/shorts/xxxxxxxxxxx
    // www.youtube.com/embed/xxxxxxxxxxx
    if (uri.host == 'www.youtube.com' &&
        uri.pathSegments.length == 2 &&
        ['shorts', 'embed'].contains(uri.pathSegments.first)) {
      return true;
    }
    return false;
  }

  String? extractVideoId(String url) {
    if (url.contains(' ')) {
      return null;
    }

    late final Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (e) {
      return null;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    // youtube.com/watch?v=xxxxxxxxxxx
    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        (uri.pathSegments.first == 'watch' ||
            uri.pathSegments.first == 'live') &&
        uri.queryParameters.containsKey('v')) {
      final videoId = uri.queryParameters['v']!;
      return _isValidId(videoId) ? videoId : null;
    }

    // youtu.be/xxxxxxxxxxx
    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      final videoId = uri.pathSegments.first;
      return _isValidId(videoId) ? videoId : null;
    }

    // www.youtube.com/shorts/xxxxxxxxxxx
    // youtube.com/shorts/xxxxxxxxxxx
    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      final pathSegments = uri.pathSegments;
      if (pathSegments.contains('shorts') && pathSegments.length >= 2) {
        final videoId = pathSegments.last;
        return _isValidId(videoId) ? videoId : null;
      }
    }

    return null;
  }

  bool _isValidId(String id) => RegExp(r'^[_\-a-zA-Z0-9]{11}$').hasMatch(id);
}

class NameID {
  final String name;
  final String id;
  NameID({required this.name, required this.id});
}
