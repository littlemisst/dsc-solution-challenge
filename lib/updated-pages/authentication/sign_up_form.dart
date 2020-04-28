import 'package:flutter/material.dart';
import 'package:me_daily/common-widgets/input_text_form_field.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/authentication/sign_up_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUp extends StatelessWidget {
  final toggleBetweenForms;
  SignUp({this.toggleBetweenForms});

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      disposeViewModel: false,
      builder: (context, model, _) => model.isLoading
          ? Loader()
          : Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 120, 50, 0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          Strings.signUp,
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
                        InputTextFormField(
                            labelText: Strings.password,
                            textEditingController: passwordController,
                            textInputType: TextInputType.visiblePassword,
                            isPassword: true,
                            validator: model.validatePassword),
                        SizedBox(height: 15),
                        InputTextFormField(
                          labelText: Strings.confirmPassword,
                          textInputType: TextInputType.visiblePassword,
                          isPassword: true,
                          validator: (String value) =>
                              model.validateConfirmPassword(
                                  value, passwordController.text),
                        ),
                        SizedBox(height: 15),
                        SubmitButton(Strings.signUp, () {
                          if (formKey.currentState.validate()) {
                            model.signUp(
                                emailController.text, passwordController.text);
                          }
                        }),
                        SizedBox(height: 15),
                        InkWell(
                          child: Text(Strings.alreadyHaveAnAccount),
                          onTap: () {
                            toggleBetweenForms();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
