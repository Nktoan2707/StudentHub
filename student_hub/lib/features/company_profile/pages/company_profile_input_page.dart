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
  bool isFirstLoad = true;

  int companyQuantityTypeCache = 0;

  @override
  Widget build(BuildContext context) {
    if (isFirstLoad) {
      context.read<CompanyProfileBloc>().add(CompanyProfileFetched());
    }

    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listener: (context, state) {
        if (state is CompanyProfileInputSuccess) {
          setState(() {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Update Profile Success')),
              );
              isFirstLoad = true;
          });
        }
      },
      child: BlocBuilder<CompanyProfileBloc, CompanyProfileState>(
        builder: (context, state) {
          if (state is CompanyProfileInitial ||
              state is CompanyProfileInputInProgress ||
              state is CompanyProfileFetchInprogress ||
              isFirstLoad) {
            companyTextController.text =
                state.currentUser.companyProfile?.companyName ?? "";

            websiteTextController.text =
                state.currentUser.companyProfile?.website ?? "";

            descriptionTextController.text =
                state.currentUser.companyProfile?.description ?? "";
            companyQuantityTypeCache =
                state.currentUser.companyProfile?.size ?? 0;
            isFirstLoad = false;
            print(companyProfile.toJson());
            return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: const Text(
                    'StudentHub',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  centerTitle: false,
                  backgroundColor: Colors.grey,
                  iconTheme: const IconThemeData(color: Colors.black),
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ));
          }

          if (state is CompanyProfileFetchNoProFile) {
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'StudentHub',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.grey,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
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
          }

          if (state is CompanyProfileFetchSuccess ||
              state is CompanyProfileInputSuccess) {
            companyProfile = state is CompanyProfileFetchSuccess
                ? (state as CompanyProfileFetchSuccess).newestCompanyProfile
                : (state as CompanyProfileInputSuccess).newestCompanyProfile;

            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'StudentHub',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.grey,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
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
                        height: 30,
                      ),
                      const HeaderText(title: 'Welcome to Student Hub'),
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
                      const PrimaryText(
                        title: 'How many people are in your company?',
                      ),
                      getEmployeeTypeRadioList(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkCustomButton(
                            title: 'Update',
                            onTap: updateButtonDidTap,
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
          }

          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'StudentHub',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                centerTitle: false,
                backgroundColor: Colors.grey,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Center(child: Text("Error occur. Please comeback later")));
        },
      ),
    );
  }

  void continueButtonDidTap() {
    companyProfile.createdAt = DateTime.now().toString();
    context
        .read<CompanyProfileBloc>()
        .add(CompanyProfileCreated(companyProfile: companyProfile));
  }

  void updateButtonDidTap() {
    companyProfile.description = descriptionTextController.text;
    companyProfile.companyName = companyTextController.text;
    companyProfile.website = websiteTextController.text;
    companyProfile.size = companyQuantityTypeCache;
    companyProfile.updatedAt = DateTime.now().toString();
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
            groupValue: EmployeeQuantityType.values[companyQuantityTypeCache],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
                companyQuantityTypeCache = 0;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('2-9 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.small,
            groupValue: EmployeeQuantityType.values[companyQuantityTypeCache],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
                companyQuantityTypeCache = 1;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('10-99 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.medium,
            groupValue: EmployeeQuantityType.values[companyQuantityTypeCache],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
                companyQuantityTypeCache = 2;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('100-1000 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.large,
            groupValue: EmployeeQuantityType.values[companyQuantityTypeCache],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
                companyQuantityTypeCache = 3;
              });
            },
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('More than 1000 employees'),
          leading: Radio<EmployeeQuantityType>(
            value: EmployeeQuantityType.xlarge,
            groupValue: EmployeeQuantityType.values[companyQuantityTypeCache],
            onChanged: (EmployeeQuantityType? value) {
              setState(() {
                companyProfile.size = value!.index;
                companyQuantityTypeCache = 4;
              });
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
