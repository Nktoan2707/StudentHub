// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_hub/data/models/domain/company_profile.dart';
import 'package:student_hub/features/company_profile/bloc/company_profile_bloc.dart';

import 'package:student_hub/widgets/components/ui_extension.dart';

class CompanyProfileInputPage extends StatefulWidget {
  static const String pageId = "/CompanyProfileInputPage";

  const CompanyProfileInputPage({super.key});

  @override
  State<CompanyProfileInputPage> createState() =>
      _CompanyProfileInputPageState();
}

class _CompanyProfileInputPageState extends State<CompanyProfileInputPage> {
  TextEditingController companyTextController = TextEditingController();
  TextEditingController websiteTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  CompanyProfile companyProfile = CompanyProfile();

  @override
  Widget build(BuildContext context) {
    context.read<CompanyProfileBloc>().add(CompanyProfileFetched());

    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listener: (context, state) {
        if (state is CompanyProfilePutSuccess) {
          setState(() {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Update Profile Success')),
              );
          });
        }
      },
      child: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
        builder: (context, state) {
          if (state is CompanyProfileInitial) {
            return const CircularProgressIndicator();
          }

          companyTextController.text =
              state.currentUser.companyProfile?.companyName ?? "";
          websiteTextController.text =
              state.currentUser.companyProfile?.website ?? "";
          descriptionTextController.text =
              state.currentUser.companyProfile?.description ?? "";

          return Scaffold(
            appBar: const TopNavigationBar(),
            body: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const HeaderText(title: 'Welcome to Student Hub'),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(
                        title:
                            'Tell us about your company and you will be on your way connect with high-skilled students'),
                    const SizedBox(height: 30),
                    const PrimaryText(
                      title: 'How many people are in your company?',
                    ),
                    getEmployeeTypeRadioList(),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(
                      title: 'Company name',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldBox(
                      heightBox: 50,
                      textController: companyTextController,
                      onChanged: (companyName) {
                        companyProfile.companyName = companyName;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(
                      title: 'Website',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldBox(
                        heightBox: 50,
                        textController: websiteTextController,
                        onChanged: (website) {
                          companyProfile.website = website;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    const PrimaryText(
                      title: 'Description',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldBox(
                        heightBox: 140,
                        textController: descriptionTextController,
                        onChanged: (description) {
                          companyProfile.description = description;
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkCustomButton(
                          title: 'Continue',
                          onTap: continueButtonDidTap,
                          padding: 10,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void continueButtonDidTap() {
    context
        .read<CompanyProfileBloc>()
        .add(CompanyProfileUpdated(companyProfile: companyProfile));
  }

  Column getEmployeeTypeRadioList() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('It\'s just me'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.onlyMe,
            groupValue: EmployeeQuantityType.values[companyProfile.size ?? 0],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('2-9 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.small,
            groupValue: EmployeeQuantityType.values[companyProfile.size ?? 0],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('10-99 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.medium,
            groupValue: EmployeeQuantityType.values[companyProfile.size ?? 0],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('100-1000 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.large,
            groupValue: EmployeeQuantityType.values[companyProfile.size ?? 0],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('More than 1000 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.xlarge,
            groupValue: EmployeeQuantityType.values[companyProfile.size ?? 0],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
              });
            },
          ),
        ),
      ],
    );
  }
}
