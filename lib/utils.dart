import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Command {
  static final all = [email, browser1, browser2];

  static const email = 'hey jack write an email to';
  static const browser1 = 'hey jack open';
  static const browser2 = 'hey jack go to';
}

class Utils {
  static void scanText(String rawText) {
    final text = rawText.toLowerCase();
    print(text.contains(Command.email));
    if (text.contains(Command.email)) {
      final body = _getTextAfterCommand(text: text, command: Command.email);
      print(body);
      openEmail(body: body);
    } else if (text.contains(Command.browser1)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser1);
      openLink(url: url);
    } else if (text.contains(Command.browser2)) {
      final url = _getTextAfterCommand(text: text, command: Command.browser2);
      openLink(url: url);
    }
  }

  static String? _getTextAfterCommand({
    required String text,
    required String command,
  }) {
    final indexCommand = text.indexOf(command);
    final indexAfter = indexCommand + command.length;

    if (indexCommand == -1) {
      return null;
    } else {
      return text.substring(indexAfter).trim();
    }
  }

  static Future openLink({@required String? url}) async {
    //url = _getTextAfterCommand(text: url!, command: Command.browser2);

    if (url!.trim().isNotEmpty) {
      await _launchUrl('https://$url.com');
    } else {
      await _launchUrl('https://google.com');
    }
  }

  static Future openEmail({@required String? body}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: body,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Write your subject',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    }
  }

  static Future _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries.map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
}
