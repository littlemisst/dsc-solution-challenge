import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:me_daily/common-widgets/input_text_form_field.dart';
import 'package:me_daily/common-widgets/loader.dart';
import 'package:me_daily/common-widgets/submitButton.dart';
import 'package:me_daily/constants/strings.dart';
import 'package:me_daily/updated-pages/authentication/sign_in_view_model.dart';
import 'package:stacked/stacked.dart';

class SignIn extends StatelessWidget {
  final toggleBetweenForms;
  SignIn({this.toggleBetweenForms});

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignInViewModel>.reactive(
      viewModelBuilder: () => SignInViewModel(),
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
                        Strings.signIn,
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

                       

                      SizedBox(height: 25),
                      SubmitButton(
                          text: Strings.signIn,
                          color: Theme.of(context).buttonColor,
                          textColor: Colors.white,
                          outlineColor: Theme.of(context).buttonColor,
                          icon: false,
                          onPressed: () => formKey.currentState.validate()
                              ? model.signInWithEmailAndPassword(
                                  emailController.text, passwordController.text)
                              : null),
                       SizedBox(height: 5),
                      SubmitButton(
                          text: Strings.signInWithGoogle, 
                          color: Colors.white,
                          textColor: Colors.black,
                          outlineColor: Theme.of(context).buttonColor,
                          icon: true,
                          onPressed: model.signInWithGoogle), 
                      
                      SizedBox(height: 20),
                      Row(children: <Widget>[
                        InkWell(
                            child: Text(Strings.forgetPassword),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Strings.resetPasswordFormRoute);
                            },
                          ),
                        Expanded(child: SizedBox(width: MediaQuery.of(context).size.width/5)),
                        InkWell(
                        child: Text(Strings.createAnAccount),
                        onTap: () {
                          toggleBetweenForms();
                        },
                      ),
                      
                       
                      ]),
                    ],
                  ),
                ),
              )),
            ),
    );
  }
}