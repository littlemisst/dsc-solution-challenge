import 'package:flutter/material.dart';
import 'package:me_daily/updated-pages/sendDetails/attachmentPage.dart';
import 'package:me_daily/updated-pages/sendDetails/basicInformationPage.dart';
import 'package:me_daily/updated-pages/sendDetails/dailyLogsPage.dart';
import 'package:multi_page_form/multi_page_form.dart';

class SendDetailsPage extends StatefulWidget {
  @override
  _SendDetailsPageState createState() => _SendDetailsPageState();
}

class _SendDetailsPageState extends State<SendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit Details',
          style: TextStyle(color: Colors.pink[100]),
        ),
        backgroundColor: Colors.white,
      ),
      body: Form(
        child: MultiPageForm(
            totalPage: 3,
            pageList: [
              BasicInformationPage(),
              DailyLogsPage(),
              AttachementPage()
            ],
            onFormSubmitted: null,
            ),
      ),
    );
  }
}
