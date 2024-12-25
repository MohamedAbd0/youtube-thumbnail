import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_thumbnail/export.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class NameID {
  final String name;
  final dynamic id;

  NameID({required this.name, required this.id});
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late NameID selectedDomain;
  late NameID selectedQuality;
  late NameID selectedFormat;

  final List<NameID> domainOptions = [
    NameID(name: "img.youtube.com", id: ThumbnailDomain.imgYouTubeCom),
    NameID(name: "i.ytimg.com", id: ThumbnailDomain.iYtImgCom),
    NameID(name: "i3.ytimg.com", id: ThumbnailDomain.i3YtImgCom),
  ];

  final List<NameID> qualityOptions = [
    NameID(name: "Full-size Image", id: ThumbnailQuality.fullSize),
    NameID(name: "Thumbnail Frame 1", id: ThumbnailQuality.frame1),
    NameID(name: "Thumbnail Frame 2", id: ThumbnailQuality.frame2),
    NameID(name: "Thumbnail Frame 3", id: ThumbnailQuality.frame3),
    NameID(name: "Default Thumbnail", id: ThumbnailQuality.defaultThumbnail),
    NameID(name: "High Quality", id: ThumbnailQuality.highQuality),
    NameID(name: "Medium Quality", id: ThumbnailQuality.mediumQuality),
    NameID(
        name: "Standard Definition", id: ThumbnailQuality.standardDefinition),
    NameID(name: "Maximum Resolution", id: ThumbnailQuality.maximumResolution),
    NameID(
        name: "Alternate High Quality 2",
        id: ThumbnailQuality.alternateHighQuality2),
    NameID(
        name: "Alternate High Quality 3",
        id: ThumbnailQuality.alternateHighQuality3),
    NameID(
        name: "Alternate Maximum Resolution 2",
        id: ThumbnailQuality.alternateMaximumResolution2),
  ];

  final List<NameID> formatOptions = [
    NameID(name: "JPG", id: ThumbnailFormat.jpg),
    NameID(name: "WEBP", id: ThumbnailFormat.webp),
  ];

  String? thumbnailUrl;

  @override
  void initState() {
    super.initState();

    selectedDomain = domainOptions.first;
    selectedQuality = qualityOptions.first;
    selectedFormat = formatOptions.first;
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
                    if (YouTubeThumbnailHelper.extractVideoId(value ?? "") !=
                        null) {
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
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
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
                      child: DropdownButtonFormField<NameID>(
                        isExpanded: true,
                        value: selectedDomain,
                        decoration: const InputDecoration(
                          labelText: 'Select Domain',
                          border: OutlineInputBorder(),
                        ),
                        items: domainOptions.map((domain) {
                          return DropdownMenuItem(
                            value: domain,
                            child: Text(domain.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedDomain = newValue!;
                          });
                          generateThumbnailUrl();
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: DropdownButtonFormField<NameID>(
                        isExpanded: true,
                        value: selectedQuality,
                        decoration: const InputDecoration(
                          labelText: 'Select Resolution',
                          border: OutlineInputBorder(),
                        ),
                        items: qualityOptions.map((quality) {
                          return DropdownMenuItem(
                            value: quality,
                            child: Text(quality.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedQuality = newValue!;
                          });
                          generateThumbnailUrl();
                        },
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: DropdownButtonFormField<NameID>(
                        isExpanded: true,
                        value: selectedFormat,
                        decoration: const InputDecoration(
                          labelText: 'Select Format',
                          border: OutlineInputBorder(),
                        ),
                        items: formatOptions.map((format) {
                          return DropdownMenuItem(
                            value: format,
                            child: Text(format.name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedFormat = newValue!;
                          });
                          generateThumbnailUrl();
                        },
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
                      );
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
                ],
                SizedBox(height: 40.h),
                const Divider(),
                SizedBox(height: 40.h),
                const Text(
                  "Resources",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    const link =
                        "https://gist.github.com/MohamedAbd0/a7198b9f44ff13ea2bcbb27a8a03682f";

                    _launchURL(link);
                  },
                  child: const Text(
                    "GitHub Source Code",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    const link =
                        "https://medium.com/@mohamed-abdo/how-to-retrieve-youtube-video-thumbnails-using-youtube-api-and-direct-urls-adc8114ff318";

                    _launchURL(link);
                  },
                  child: const Text(
                    "Read the Article",
                    style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    // Open the URL in the browser
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  void generateThumbnailUrl() {
    if (_textEditingController.text.trim().isEmpty) {
      return;
    }
    setState(() {
      thumbnailUrl = YouTubeThumbnailHelper.generateThumbnailUrl(
        videoUrl: _textEditingController.text.trim(),
        domain: selectedDomain.id,
        quality: selectedQuality.id,
        format: selectedFormat.id,
      );
    });
  }
}
