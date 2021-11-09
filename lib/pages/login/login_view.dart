import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:so_exam/components/textfield_mobile_number.dart';
import 'package:so_exam/components/textfield_passowrd_widget.dart';
import 'package:so_exam/core/app.dart';
import 'package:so_exam/core/helpers/form_validator.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: controller.formkey,
        child: Center(
          child: Wrap(
            children: [
              Column(
                children: [
                  Text(
                    'SEA OIL',
                    style: Theme.of(context).textTheme.headline1,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Login:',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFieldWidget(
                          placeholder: 'Mobile number',
                          controller: controller.mobilenumberTextController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ], // Only numbers can be entered
                          validator: MultiValidator([
                            MinLengthValidator(
                              11,
                              errorText: 'Mobile number should be 11 digit',
                            ),
                            MaxLengthValidator(11,
                                errorText: 'Mobile number should be 11 digit')
                          ]),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFieldPasswordWidget(
                          prefix: const Icon(Icons.lock_outline_rounded),
                          controller: controller.passwordTextController,
                          placeholder: 'Password',
                          validator: MultiValidator([
                            RequiredValidator(errorText: '* Required'),
                          ]),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (controller.formkey.currentState!.validate()) {
                                EasyLoading.show();
                                try {
                                  final userLogin = await controller.login(
                                    controller.mobilenumberTextController.text,
                                    controller.passwordTextController.text,
                                  );
                                  await controller.userManager
                                      .cacheLogin(userLogin);
                                  await controller.userManager
                                      .preloadCachedLogin();
                                  EasyLoading.dismiss();
                                  Get.offAllNamed(AppRoutes.dashboard.value);
                                } catch (error) {
                                  EasyLoading.dismiss();
                                  await showOkAlertDialog(
                                      context: context,
                                      title: error.toString());
                                }
                              }
                            },
                            child: const Text('Sign in'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
