import 'package:besafe/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:besafe/shared/widgets.dart';
import 'package:besafe/models.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late final TextEditingController firstNameController,
      lastNameController,
      dateController,
      cityController,
      addressController,
      emailController,
      phoneController,
      passwordController,
      passwordConfirmationController;
  late final GenderDropdown genderDropdown;
  int registrationStep = 1;

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    dateController = TextEditingController();
    cityController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    genderDropdown = GenderDropdown();

    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    dateController.dispose();
    cityController.dispose();
    addressController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();

    super.dispose();
  }

  Column _registrationStepOne() {
    return Column(
      children: [
        InputEntry(
            text: 'First Name',
            widget: FormattedTextField(
                text: 'Name', controller: firstNameController)),
        InputEntry(
            text: 'Last name',
            widget: FormattedTextField(
                text: 'Surname', controller: lastNameController)),
        InputEntry(
            text: 'Date of birth',
            widget: DatePicker(controller: dateController)),
        InputEntry(
            text: 'Gender', widget: AlignedInputField(widget: genderDropdown)),
        InputEntry(
            text: 'City',
            widget:
                FormattedTextField(text: 'City', controller: cityController)),
        InputEntry(
            text: 'Address',
            widget: FormattedTextField(
                text: 'Address', controller: addressController)),
        Container(
            margin: const EdgeInsets.only(top: 16),
            child: PrimaryButton(
                text: 'Next',
                onPressed: () {
                  if (firstNameController.text != '' &&
                      lastNameController.text != '' &&
                      dateController.text != '' &&
                      genderDropdown.genderValue != '' &&
                      cityController.text != '' &&
                      addressController.text != '') {
                    setState(() {
                      registrationStep = 2;
                    });
                  }
                })),
      ],
    );
  }

  Column _registrationStepTwo() {
    return Column(
      children: [
        InputEntry(
            text: 'Email',
            widget:
                FormattedTextField(text: 'Email', controller: emailController)),
        InputEntry(
            text: 'Phone number',
            widget: FormattedTextField(
                text: '+998 ()', controller: phoneController)),
        InputEntry(
            text: 'Password',
            widget: FormattedTextField(
                text: 'Password',
                controller: passwordController,
                obscureText: true)),
        InputEntry(
            text: 'Confirm password',
            widget: FormattedTextField(
                text: 'Password',
                controller: passwordConfirmationController,
                obscureText: true)),
        Container(
            margin: const EdgeInsets.only(top: 16),
            child: PrimaryButton(
                text: 'Sign up',
                onPressed: () {
                  final UserModel requestUser = UserModel(
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      phone: phoneController.text,
                      email: emailController.text,
                      birthDate:
                          DateFormat("yyyy-MM-dd").parse(dateController.text),
                      gender: genderDropdown.genderValue,
                      homeAddress:
                          '${cityController.text}, ${addressController.text}',
                      password: passwordController.text);

                  UserApi.registrationRequest(requestUser).then(
                      (value) => Navigator.popAndPushNamed(context, '/home'));
                }))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/registration-bg.png'),
          fit: BoxFit.contain,
          alignment: Alignment.topCenter,
        )),
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Spacer(),
            const Spacer(),
            const MainHeader(text: 'Registration'),
            registrationStep == 1
                ? _registrationStepOne()
                : _registrationStepTwo(),
            const Spacer(),
            const AlreadyHaveAnAccountWidget(),
          ],
        ),
      ),
    );
  }
}
