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

  final List<String> urlExamples = [
    'https://www.youtube.com/watch?v=VIDEO_ID',
    'https://youtu.be/VIDEO_ID',
    'https://www.youtube.com/embed/VIDEO_ID',
    'https://www.youtube.com/watch?v=VIDEO_ID&t=60s',
  ];

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
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.isMobile(context)
              ? 16.w
              : MediaQuery.of(context).size.width * 0.1,
          vertical: ResponsiveLayout.isMobile(context)
              ? 20.h
              : MediaQuery.of(context).size.width * 0.03,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 40.h),
                  child: Column(
                    children: [
                      Text(
                        "YouTube Thumbnail Generator",
                        style: TextStyle(
                          fontSize: ResponsiveLayout.isMobile(context)
                              ? 28.sp
                              : 42.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1E293B),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        "Extract high-quality thumbnails from any YouTube video instantly",
                        style: TextStyle(
                          fontSize: ResponsiveLayout.isMobile(context)
                              ? 16.sp
                              : 18.sp,
                          color: const Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                // Features section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(bottom: 32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!ResponsiveLayout.isMobile(context))
                        Container(
                          width: 120,
                          height: 120,
                          margin: const EdgeInsets.only(right: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.image,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Supported URL Formats",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1E293B),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ...urlExamples
                                .map((example) => Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            margin: const EdgeInsets.only(
                                                top: 8, right: 12),
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF3B82F6),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              example,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: const Color(0xFF3B82F6),
                                                fontFamily: 'monospace',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                                .toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
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
                      labelStyle: TextStyle(
                        color: const Color(0xFF64748B),
                        fontSize: 16.sp,
                      ),
                      hintText: 'https://www.youtube.com/watch?v=...',
                      hintStyle: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14.sp,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                            color: Color(0xFF3B82F6), width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFEF4444)),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(20),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF10B981),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              generateThumbnailUrl();
                            }
                          },
                          child: Text(
                            'Generate',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 15,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Customize Your Thumbnail",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      ResponsiveLayout.isMobile(context)
                          ? Column(
                              children: [
                                _buildDropdown(
                                  "Domain",
                                  selectedDomain,
                                  domainOptions,
                                  (newValue) {
                                    setState(() {
                                      selectedDomain = newValue!;
                                    });
                                    generateThumbnailUrl();
                                  },
                                ),
                                SizedBox(height: 16.h),
                                _buildDropdown(
                                  "Resolution",
                                  selectedQuality,
                                  qualityOptions,
                                  (newValue) {
                                    setState(() {
                                      selectedQuality = newValue!;
                                    });
                                    generateThumbnailUrl();
                                  },
                                ),
                                SizedBox(height: 16.h),
                                _buildDropdown(
                                  "Format",
                                  selectedFormat,
                                  formatOptions,
                                  (newValue) {
                                    setState(() {
                                      selectedFormat = newValue!;
                                    });
                                    generateThumbnailUrl();
                                  },
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Expanded(
                                  child: _buildDropdown(
                                    "Domain",
                                    selectedDomain,
                                    domainOptions,
                                    (newValue) {
                                      setState(() {
                                        selectedDomain = newValue!;
                                      });
                                      generateThumbnailUrl();
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: _buildDropdown(
                                    "Resolution",
                                    selectedQuality,
                                    qualityOptions,
                                    (newValue) {
                                      setState(() {
                                        selectedQuality = newValue!;
                                      });
                                      generateThumbnailUrl();
                                    },
                                  ),
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: _buildDropdown(
                                    "Format",
                                    selectedFormat,
                                    formatOptions,
                                    (newValue) {
                                      setState(() {
                                        selectedFormat = newValue!;
                                      });
                                      generateThumbnailUrl();
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (thumbnailUrl != null) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        thumbnailUrl!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                              height: 300,
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: const Color(0xFF3B82F6),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Loading thumbnail...',
                                    style: TextStyle(
                                      color: const Color(0xFF64748B),
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 300,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 60,
                                  color: Color(0xFFEF4444),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Failed to load thumbnail',
                                  style: TextStyle(
                                    color: const Color(0xFFEF4444),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFE2E8F0)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Thumbnail URL',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: SelectableText(
                                  thumbnailUrl ?? "",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: const Color(0xFF3B82F6),
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                          text: thumbnailUrl ?? ""))
                                      .then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            'URL copied to clipboard!'),
                                        backgroundColor:
                                            const Color(0xFF10B981),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(
                                  Icons.copy,
                                  size: 16,
                                ),
                                label: const Text('Copy'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF10B981),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildDropdown(
    String label,
    NameID selectedValue,
    List<NameID> options,
    Function(NameID?) onChanged,
  ) {
    return DropdownButtonFormField<NameID>(
      isExpanded: true,
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: const Color(0xFF64748B),
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        filled: true,
        fillColor: const Color(0xFFF8FAFC),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      style: TextStyle(
        color: const Color(0xFF1E293B),
        fontSize: 14.sp,
      ),
      dropdownColor: Colors.white,
      items: options.map((option) {
        return DropdownMenuItem(
          value: option,
          child: Text(
            option.name,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF1E293B),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
