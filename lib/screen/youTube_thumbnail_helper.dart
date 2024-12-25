/// A helper class for generating YouTube video thumbnail URLs based on video URL, domain, quality, and format.
///
/// ## Features:
/// - Supports different YouTube thumbnail domains.
/// - Offers a variety of thumbnail qualities.
/// - Allows the use of JPG and WEBP formats.
/// - Validates YouTube video URLs and extracts video IDs.
/// - Dynamically generates thumbnail URLs.

/// Enum to represent the supported domains
enum ThumbnailDomain {
  imgYouTubeCom,
  iYtImgCom,
  i3YtImgCom,
}

/// Enum to represent the supported thumbnail resolutions
enum ThumbnailQuality {
  fullSize,
  frame1,
  frame2,
  frame3,
  defaultThumbnail,
  highQuality,
  mediumQuality,
  standardDefinition,
  maximumResolution,
  alternateHighQuality2,
  alternateHighQuality3,
  alternateMaximumResolution2,
}

/// Enum to represent the supported image formats
enum ThumbnailFormat {
  jpg,
  webp,
}

/// Helper class to generate YouTube thumbnail URL
class YouTubeThumbnailHelper {
  /// Maps the `ThumbnailDomain` enum to its corresponding domain string
  static const Map<ThumbnailDomain, String> _domainMap = {
    ThumbnailDomain.imgYouTubeCom: 'img.youtube.com',
    ThumbnailDomain.iYtImgCom: 'i.ytimg.com',
    ThumbnailDomain.i3YtImgCom: 'i3.ytimg.com',
  };

  /// Maps the `ThumbnailQuality` enum to its corresponding thumbnail ID
  static const Map<ThumbnailQuality, String> _qualityMap = {
    ThumbnailQuality.fullSize: '0',
    ThumbnailQuality.frame1: '1',
    ThumbnailQuality.frame2: '2',
    ThumbnailQuality.frame3: '3',
    ThumbnailQuality.defaultThumbnail: 'default',
    ThumbnailQuality.highQuality: 'hqdefault',
    ThumbnailQuality.mediumQuality: 'mqdefault',
    ThumbnailQuality.standardDefinition: 'sddefault',
    ThumbnailQuality.maximumResolution: 'maxresdefault',
    ThumbnailQuality.alternateHighQuality2: 'hq2',
    ThumbnailQuality.alternateHighQuality3: 'hq3',
    ThumbnailQuality.alternateMaximumResolution2: 'maxres2',
  };

  /// Maps the `ThumbnailFormat` enum to its corresponding file extension
  static const Map<ThumbnailFormat, String> _formatMap = {
    ThumbnailFormat.jpg: 'jpg',
    ThumbnailFormat.webp: 'webp',
  };

  /// Validates a YouTube video URL and extracts the video ID
  ///
  /// - Parameter `url`: The YouTube video URL to validate.
  /// - Returns: The extracted video ID if valid; otherwise, `null`.
  static String? extractVideoId(String url) {
    late final Uri uri;
    try {
      uri = Uri.parse(url);
    } catch (_) {
      return null;
    }

    if (!['https', 'http'].contains(uri.scheme)) {
      return null;
    }

    if (['youtube.com', 'www.youtube.com', 'm.youtube.com']
            .contains(uri.host) &&
        uri.pathSegments.isNotEmpty &&
        uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v'];
    }

    if (uri.host == 'youtu.be' && uri.pathSegments.isNotEmpty) {
      return uri.pathSegments.first;
    }

    if (uri.host == 'www.youtube.com' || uri.host == 'youtube.com') {
      if (uri.pathSegments.contains('shorts') && uri.pathSegments.length >= 2) {
        return uri.pathSegments.last;
      }
    }

    return null;
  }

  /// Generates the thumbnail URL based on the provided parameters
  ///
  /// - Parameters:
  ///   - `videoUrl`: The URL of the YouTube video.
  ///   - `domain`: The domain to use for the thumbnail. Defaults to `ThumbnailDomain.imgYouTubeCom`.
  ///   - `quality`: The quality of the thumbnail. Defaults to `ThumbnailQuality.highQuality`.
  ///   - `format`: The image format for the thumbnail (e.g., JPG or WEBP). Defaults to `ThumbnailFormat.jpg`.
  /// - Returns: The generated thumbnail URL if valid; otherwise, `null`.
  static String? generateThumbnailUrl(
      {required String videoUrl,
      ThumbnailDomain domain = ThumbnailDomain.imgYouTubeCom,
      ThumbnailQuality quality = ThumbnailQuality.highQuality,
      ThumbnailFormat format = ThumbnailFormat.jpg}) {
    final videoId = extractVideoId(videoUrl);

    if (videoId == null) {
      return null;
    }

    final domainString = _domainMap[domain]!;
    final qualityString = _qualityMap[quality]!;

    // Use "vi_webp" path for webp format
    final pathPrefix = format == ThumbnailFormat.webp ? "vi_webp" : "vi";
    final formatString = _formatMap[format]!;

    return 'https://$domainString/$pathPrefix/$videoId/$qualityString.$formatString';
  }
}
