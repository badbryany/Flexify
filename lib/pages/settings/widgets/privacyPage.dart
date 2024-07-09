import 'package:collection/collection.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class PrivacyPage extends StatelessWidget {
  PrivacyPage({super.key});

  final List<Map<String, String>> content = [
    {
      'title': 'Last Updated: 09 Juli 2024',
      'text':
          'Welcome to Flexify! We are committed to protecting your privacy and ensuring that your personal information is handled in a safe and responsible manner. This Privacy Policy outlines how we collect, use, and protect your personal data.',
    },
    {
      'title': 'Information We Collect',
      'text': '''We collect and process the following information:
\n\t - First name and surname
\n\t - Username
\n\t - Address
\n\t - Card information
\n\t - Sport data
\n\t - Usage data and preferences
\n\t - Communication history with our support team''',
    },
    {
      'title': 'How We Use Your Information',
      'text': '''We use the information we collect to:
\n\t - Provide and maintain our Services
\n\t - Process transactions and send you related information
\n\t - Improve, personalize, and expand our Services
\n\t - Understand and analyze how you use our Services
\n\t - Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the Service, and for marketing and promotional purposes
\n\t - Process your transactions securely
''',
    },
    {
      'title': 'Sharing Your Information',
      'text':
          '''We do not share your personal information with third parties except in the following circumstances:
\n\t - With service providers who help us operate our Services
\n\t - When we believe in good faith that disclosure is necessary to protect our rights, protect your safety or the safety of others, investigate fraud, or respond to a government request
          ''',
    },
    {
      'title': 'Data Security',
      'text':
          'We implement appropriate technical and organizational measures to protect your personal data against accidental or unlawful destruction, loss, alteration, unauthorized disclosure, or access. However, no method of transmission over the Internet or method of electronic storage is 100% secure, so we cannot guarantee absolute security.',
    },
    {
      'title': 'Your Data Protection Rights',
      'text':
          '''Depending on your location, you may have the following rights regarding your personal data:
\n\t - The right to access – You have the right to request copies of your personal data.
\n\t - The right to rectification – You have the right to request that we correct any information you believe is inaccurate or complete information you believe

''',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Navbar(
              title: 'Privacy policy',
              titleSize: global.width(context) * .075,
            ),
            global.smallHeight(context),
            ...content.mapIndexed(
              (index, e) => Padding(
                padding: EdgeInsets.symmetric(
                  vertical: global.height(context) * .0125,
                ),
                child: Center(
                  child: SizedBox(
                    width: global.containerWidth(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          index != 0
                              ? '$index. ${e['title']}'
                              : e['title'] as String,
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: index != 0
                                ? global.width(context) * .07
                                : global.width(context) * .05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        global.smallHeight(context),
                        Text(
                          e['text'] as String,
                          style: TextStyle(
                            color: Theme.of(context).focusColor,
                            fontSize: global.width(context) * .04,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
