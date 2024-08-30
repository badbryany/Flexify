import 'package:collection/collection.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class PrivacyPage extends StatelessWidget {
  PrivacyPage({super.key});

  final List<Map<String, String>> content = [
    {
      'title': 'Effective Date: 09 Juli 2024',
      'text': '''Welcome to Flexify!
'This Privacy Policy explains how Flexify ("we," "our," or "us") collects, uses, and discloses information about you when you use our mobile application, website, and other online products and services (collectively, the "Services"). We are committed to protecting your privacy and ensuring that your personal information is handled securely and responsibly.\n\t
''',
    },
    {
      'title': 'Information We Collect',
      'text':
          '''We collect various types of information in connection with the Services, including:
\n\ta. Personal Information Account Information: When you sign up for an account, we collect your name, email address, username, password, and other registration information.
Profile Information: You may choose to provide additional information in your profile, such as your profile picture, gender, age, location, and fitness goals.
Health and Fitness Data: This includes data such as your weight, height, heart rate, calories burned, workout duration, and activity levels, which you provide or which are collected through devices like fitness trackers.
\n\tb. Usage Information
Activity Data: We collect data related to your activities and workouts, such as GPS location, distance, time, speed, and route.
Device Information: We may collect information about the device you use to access our Services, including IP address, operating system, device type, and app version.
\n\tc. Cookies and Tracking Technologies
Cookies: We use cookies and similar technologies to track your activity on our Services and hold certain information. You can control the use of cookies through your browser settings.
Analytics: We use third-party analytics tools to help us understand how users interact with our Services.\n\t
''',
    },
    {
      'title': 'How We Use Your Information',
      'text': '''We use the information we collect for the following purposes:
\n\tTo Provide and Improve Our Services: To operate, maintain, and improve our Services, including providing personalized recommendations and content.
\n\tTo Communicate with You: To send you updates, notifications, and information related to your account, as well as marketing messages (if you have opted in).
\n\tTo Analyze and Understand Trends: To analyze usage patterns and trends to improve our Services and develop new features.
\n\tTo Ensure Security: To protect our Services, users, and the public from unauthorized access, fraudulent activities, or any other harmful activity.
''',
    },
    {
      'title': 'Sharing Your Information',
      'text':
          '''We do not sell, trade, or rent your personal information to third parties. We may share your information in the following circumstances:
\n\tWith Your Consent: We will share your information with third parties when you give us explicit permission to do so.
\n\tWith Service Providers: We may share your information with third-party vendors, consultants, and other service providers who need access to such information to perform services on our behalf.
\n\tFor Legal Reasons: We may disclose your information if required by law, legal process, or governmental request.\n\t
''',
    },
    {
      'title': 'Data Retention',
      'text':
          '''We retain your personal information for as long as necessary to provide you with the Services and for legitimate business purposes. If you request to delete your account, we will delete your personal information in accordance with our data retention policies, except where we are required to retain it by law.\n\t
          '''
    },
    {
      'title': 'Data Security',
      'text':
          '''We implement appropriate technical and organizational measures to protect your personal data against accidental or unlawful destruction, loss, alteration, unauthorized disclosure, or access. However, no method of transmission over the Internet or method of electronic storage is 100% secure, so we cannot guarantee absolute security.
          ''',
    },
    {
      'title': 'Your Data Protection Rights',
      'text': '''
You have the following rights regarding your personal information:
\n\tAccess and Update: You can access and update your personal information through your account settings.
\n\tData Portability: You have the right to request a copy of your data in a structured, commonly used, and machine-readable format.
\n\tDeletion: You can request that we delete your personal information, subject to certain exceptions.
\n\tOpt-Out: You can opt-out of receiving marketing communications from us by following the unsubscribe instructions in those communications.\n\t
''',
    },
    {
      'title': 'Changes to this Privacy Policy',
      'text': '''
We may update this Privacy Policy from time to time. If we make significant changes, we will notify you by posting the new Privacy Policy on our website and updating the "Effective Date" above. Your continued use of the Services after the effective date of the revised Privacy Policy constitutes your acceptance of the changes.
'''
    },
    {
      'title': 'Contact Us',
      'text': '''
9. Contact Us
If you have any questions or concerns about this Privacy Policy, please contact us at:

\n\t[Company Name]
\n\t[Telephone]
\n\t[Address]
\n\t[Email]
'''
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Navbar(
              title: 'Privacy Policy',
              titleSize: global.width(context) * .075,
            ),
            global.smallHeight(context),
            ...content.mapIndexed(
              (index, e) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: global.containerPadding,
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
