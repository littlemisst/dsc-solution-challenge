import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/input_text_form_field.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/authentication/reset_password_view_model.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ResetPasswordViewModel>.reactive(
      viewModelBuilder: () => ResetPasswordViewModel(),
      disposeViewModel: false,
      builder: (context, model, _) => model.isLoading
          ? Loader()
          : Scaffold(
              appBar: AppBar(
                leading: FlatButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              body: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(50, 120, 50, 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        Strings.forgetPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 25),
                      InputTextFormField(
                          labelText: Strings.email,
                          textEditingController: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: model.validateEmail),
                      SizedBox(height: 15),
                      SubmitButton(
                        Strings.resetPassword,
                        () {
                          if (formKey.currentState.validate()) {
                            model.resetPassword(emailController.text);
                            Navigator.pushNamed(
                                context, Strings.resetPasswordRoute);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )),
            ),
    );
  }
}
