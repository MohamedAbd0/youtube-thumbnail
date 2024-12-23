import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 40.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Name
            const Text(
              "Dev by Mohamed Abdo",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Social Links
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _SocialIcon(
                  icon: FontAwesomeIcons.github,
                  url: "https://github.com/MohamedAbd0",
                ),
                SizedBox(width: 30.w),
                const _SocialIcon(
                  icon: FontAwesomeIcons.medium,
                  url: "https://mohamed-abdo.medium.com/",
                ),
                SizedBox(width: 30.w),
                const _SocialIcon(
                  icon: FontAwesomeIcons.linkedin,
                  url: "https://www.linkedin.com/in/mohamed-abdo95/",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon({
    Key? key,
    required this.icon,
    required this.url,
  }) : super(key: key);

  void _launchURL(String url) async {
    // Open the URL in the browser
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: FaIcon(
        icon,
        size: 30,
        color: Colors.white,
      ),
    );
  }
}
