import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class feedbackPage extends StatefulWidget {
  @override
  _feedbackPageState createState() => _feedbackPageState();
}

class _feedbackPageState extends State<feedbackPage> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
String subject,body;
  Future<void> submit()async
  {
    final Email email=Email(
      body: body,
      subject: subject,
      recipients: ['yashsp1158@gmail.com'],
      isHTML: false
    );
    await FlutterEmailSender.send(email);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/Feedback.png'),
          fit: BoxFit.fill
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Container(),
          title: Text(
            'FeedBack Form',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(22, 102, 225, 1)),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Color.fromRGBO(22, 102, 225, 1))),
                child: TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter title please';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(.8), fontFamily: 'R'),
                      hintText: "Title"),
                  onChanged: (input) {
                    subject=input;
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0),
                padding: EdgeInsets.only(left: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(color: Color.fromRGBO(22, 102, 225, 1))),
                child: TextFormField(
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your suggestions or query';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(.8), fontFamily: 'R'),
                      hintText: "Enter your suggestions or query"),
                  onChanged: (input) {body=input;},
                ),
              ),
              SizedBox(
                height: 60.0,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))
                ),
                child: MaterialButton(
                    color: Color.fromRGBO(22, 102, 225, 1),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      submit();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
