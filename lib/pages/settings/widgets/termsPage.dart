import 'package:collection/collection.dart';
import 'package:flexify/widgets/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flexify/data/globalVariables.dart' as global;

class TermsPage extends StatelessWidget {
  TermsPage({super.key});

  final List<Map<String, String>> content = [
    {
      'title': 'Last Updated: 09 Juli 2024',
      'text':
          'Welcome to Flexify! These Terms of Use ("Terms") govern your access to and use of our application and services ("Services"). By using our Services, you agree to be bound by these Terms. If you do not agree to these Terms, please do not use our Services.',
    },
    {
      'title': 'Acceptance of Terms',
      'text':
          'By accessing or using the Services, you agree to comply with and be bound by these Terms and all applicable laws and regulations. If you do not agree with any part of these Terms, you must discontinue use of the Services immediately.',
    },
    {
      'title': 'User Registration',
      'text':
          '''To access certain features of the Services, you may need to register and create an account. When you create an account, you agree to:
          \n\t - Provide accurate, current, and complete information during the registration process.
          \n\t - Maintain and promptly update your account information to keep it accurate, current, and complete.
          \n\t - Keep your password secure and not share it with others.
          \n\t - Notify us immediately of any unauthorized use of your account.''',
    },
    {
      'title': 'Personal Data Collection',
      'text':
          '''We collect and store personal data including, but not limited to:
          \n\t - First name
          \n\t - Surname
          \n\t - Username
          \n\t - Address
          \n\t - Card information
          \n\t - Sport data
          \nFor more information on how we handle your personal data, please refer to our Privacy Policy.
          ''',
    },
    {
      'title': 'Use of Services',
      'text':
          '''You agree to use the Services only for lawful purposes and in accordance with these Terms. You agree not to:
      \n\t - Use the Services in any manner that could disable, overburden, damage, or impair the Services.
      \n\t - Use any robot, spider, or other automatic device, process, or means to access the Services.
      \n\t - Use the Services for any unauthorized or illegal activities.
''',
    },
    {
      'title': 'Payment and Subscription',
      'text':
          'If you choose to purchase a subscription or make a payment through the Services, you agree to provide a valid payment method. All payments are subject to our billing and payment policies.',
    },
    {
      'title': 'Termination',
      'text':
          'We reserve the right to terminate or suspend your account and access to the Services at our sole discretion, without notice and liability, for conduct that we believe violates these Terms or is harmful to other users of the Services, us, or third parties.',
    },
    {
      'title': 'Intellectual Property',
      'text':
          'All content, features, and functionality of the Services, including but not limited to text, graphics, logos, and software, are the exclusive property of Flexify and are protected by copyright, trademark, and other intellectual property laws.',
    },
    {
      'title': 'Limitation of Liability',
      'text': '''
      To the fullest extent permitted by law, Flexify shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues, whether incurred directly or indirectly, or any loss of data, use, goodwill, or other intangible losses, resulting from:

      \n\t - Your use or inability to use the Services.
      \n\t - Any unauthorized access to or use of our servers and/or any personal information stored therein.
      \n\t - Any interruption or cessation of transmission to or from the Services.
      \n\t - Any bugs, viruses, trojan horses, or the like that may be transmitted to or through the Services by any third party.
      ''',
    },
    {
      'title': 'Governing Law',
      'text':
          'These Terms shall be governed and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions.',
    },
    {
      'title': 'Changes to Terms',
      'text':
          'We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days\' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion.',
    },
    {
      'title': 'Contact Us',
      'text':
          '''If you have any questions about these Terms, please contact us at flexify.20.oskarkel@spamgourmet.com.
          By using our Services, you acknowledge that you have read, understood, and agree to be bound by these Terms. Thank you for using Flexify!''',
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
              title: 'Terms of use',
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
