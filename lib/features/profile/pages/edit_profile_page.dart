import 'dart:io';

import 'package:fansedu/domain/entity/profile_entity.dart';
import 'package:image_picker/image_picker.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fansedu/core/config/model/info_item.dart';
import 'package:fansedu/core/constants/constants.dart';
import 'package:fansedu/core/helpers/permission_helper.dart';
import 'package:fansedu/core/widgets/action_button_widget.dart';
import 'package:fansedu/core/widgets/color_widget.dart';
import 'package:fansedu/core/widgets/container_widget.dart';
import 'package:fansedu/core/widgets/text_form_widget.dart';
import 'package:fansedu/core/widgets/text_widget.dart';
import 'package:fansedu/features/profile/widgets/bottom_sheet_gender.dart';
import 'package:fansedu/features/profile/widgets/bottom_sheet_grade.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EditProfilePage extends StatefulWidget {
  final DataProfileEntity profileEntity;
  const EditProfilePage({super.key, required this.profileEntity});

  @override
  State<StatefulWidget> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  DateTime? _selectedDate;
  String filePath = '';

  InfoItem selectedGrade = InfoItem();
  InfoItem selectedGender = InfoItem();

  final _formKey = GlobalKey<FormState>();

  bool checkCondition() {
    return _formKey.currentState?.validate() ?? false;
  }

  @override
  void initState() {
    initialCondition();
    super.initState();
  }

  void initialCondition() async {
    if (widget.profileEntity.user_id.isNotEmpty) {
      _nameController.text = widget.profileEntity.full_name;
      _emailController.text = widget.profileEntity.email;
      _addressController.text = widget.profileEntity.address;
      _dobController.text = widget.profileEntity.date_of_birth;
      _institutionController.text = widget.profileEntity.institution_name;
      _gradeController.text = widget.profileEntity.grade;
      _genderController.text = widget.profileEntity.gender;
      _phoneController.text = widget.profileEntity.phone_number;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Loadable(
      backgroundColor: Colors.white,
      appBar: BackAppBar(context, "Edit Profile", backgroundColor: Colors.white),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        child: ActionButtonWidget(
          title: "Save Update",
          onTap: checkCondition() ? () {} : null,
          isActive: checkCondition()
        ).padded()
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: LeftAlignedColumn(
              children: [
                Center(
                  child: Stack(
                    children: [
                      GestureDetector(
                          onTap: () => _onEditImage(context),
                          child: (filePath.isNotEmpty)
                              ? _buildPhotoProfileContainer(FileImage(
                              File(filePath)),
                          ) : _placeholder()),
                      (filePath.isNotEmpty)
                          ? const SizedBox()
                          : Container(
                        margin: const EdgeInsets.fromLTRB(100, 100, 0, 0),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorWidget.primaryColor,
                        ),
                        child: GestureDetector(
                          onTap: () => _onEditImage(context),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormWidget(
                  labelText: "Full Name",
                  hintText: "Enter Full Name",
                  controller: _nameController,
                  onChanged: (_) { setState(() {}); },
                  type: TextFieldType.text
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Email Address",
                    hintText: "Enter Email Address",
                    controller: _emailController,
                    onChanged: (_) { setState(() {}); },
                    type: TextFieldType.email,
                    isDisableForm: true,
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                  labelText: "Phone Number",
                  hintText: "Enter Your Phone Number",
                  controller: _phoneController,
                  onChanged: (_) { setState(() {}); },
                  type: TextFieldType.number
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Address",
                    hintText: "Enter Address",
                    controller: _addressController,
                    onChanged: (_) { setState(() {}); },
                    type: TextFieldType.multiline,
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Gender",
                    hintText: "Choose Gender",
                    controller: _genderController,
                    suffixIcon: Icon(Icons.keyboard_arrow_down, size: 24),
                    tapAction: () {
                      showSheet(context, BottomSheetGender(
                          selectedValue: selectedGender,
                          onTap: (val) {
                            selectedGender = val;
                            _genderController.text = selectedGender.content ?? '';
                            setState(() {});
                          },
                          gender: [
                            InfoItem(title: 'male', content: 'Male'),
                            InfoItem(title: 'female', content: 'Female')
                          ]
                      ));
                    },
                    onChanged: (_) {},
                    type: TextFieldType.options
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Date of Birth",
                    hintText: "Enter Date of Birth",
                    controller: _dobController,
                    onChanged: (_) {},
                    tapAction: () async {
                      final value = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1990),
                        lastDate: DateTime(2030, 12, 31),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        initialDate: (_selectedDate != null) ? _selectedDate : DateTime.now(),
                      );
                      if (value != null) {
                        _selectedDate = value;
                        _dobController.text = DateFormat.yMMMd().format(value);
                        setState(() {});
                      }
                    },
                    type: TextFieldType.date
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Grade",
                    hintText: "Choose Grade",
                    controller: _gradeController,
                    suffixIcon: Icon(Icons.keyboard_arrow_down, size: 24),
                    tapAction: () {
                      showSheet(context, BottomSheetGrade(
                          selectedValue: selectedGrade,
                          onTap: (val) {
                            selectedGrade = val;
                            _gradeController.text = 'Grade ${selectedGrade.content}';
                            setState(() {});
                          },
                          grades: [
                            InfoItem(title: 'ix', content: 'IX'),
                            InfoItem(title: 'x', content: 'X'),
                            InfoItem(title: 'xi', content: 'XI'),
                            InfoItem(title: 'xii', content: 'XII'),
                          ]
                      ));
                    },
                    onChanged: (_) {},
                    type: TextFieldType.options
                ).horizontalPadded(24).topPadded(),
                TextFormWidget(
                    labelText: "Institution Name",
                    hintText: "Enter Your Institution Name",
                    controller: _institutionController,
                    onChanged: (_) { setState(() {}); },
                    type: TextFieldType.text
                ).horizontalPadded(24).topPadded(),
              ],
            ),
          ),
        )
      )
    );
  }

  Container _buildPhotoProfileContainer(ImageProvider<Object> imageProvider) {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 110,
      width: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(fit: BoxFit.cover, image: imageProvider),
        shape: BoxShape.circle,
        color: ColorWidget.accentColor,
      ),
    );
  }

  Container _placeholder() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFDDE6E5),
      ),
      child: Icon(
        Icons.image_rounded,
        size: 100,
        color: ColorWidget.primaryColor,
      ).padded(),
    );
  }

  void _onEditImage(BuildContext ctx) async {
    showSheet(
        ctx,
        BottomDrawer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextWidget.jakartaSansSemiBold("Choose Source Image", size: 18, color: Colors.black).horizontalPadded().bottomPadded(),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      if (await PermissionHelper.checkStatusPermissionCamera()) {
                        final XFile? selectedFile = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 1);
                        if (selectedFile != null) {
                          final size = await selectedFile.readAsBytes();
                          if ((size.lengthInBytes / 1024) < 1024) {
                            context.router.maybePop().then(
                                  (_) {
                                setState(() {
                                  filePath = selectedFile.path;
                                  // sl<FormPengaduanBloc>().add(AssetUploadEvent(filePath: filePath, imagePaths: [filePath]));
                                });
                              },
                            );
                          } else {
                            showError(context, "Image too big");
                          }
                        }
                      } else {
                        showAlertPermission(context,
                            text: "Allow Fansedu to use camera",
                            onTap: () =>
                                PermissionHelper.requestCameraPermissionHelpers());
                      }
                    },
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 16),
                          child: Icon(Icons.camera_alt, color: ColorWidget.primaryColor),
                        ),
                        Flexible(
                            child: TextWidget.jakartaSansRegular("Take Image",
                                size: 14, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
                const Divider(thickness: 2).verticalPadded(8),
                SizedBox(
                  width: double.infinity,
                  child: GestureDetector(
                    onTap: () async {
                      if (await PermissionHelper.checkStatusPermissionPhotoGallery() ||
                          Platform.isAndroid) {
                        final XFile? selectedFile = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 1);
                        if (selectedFile != null) {
                          final size = await selectedFile.readAsBytes();
                          if ((size.lengthInBytes / 1024) < 1024) {
                            context.router.maybePop().then(
                                  (_) {
                                setState(() {
                                  filePath = selectedFile.path;
                                  // sl<FormPengaduanBloc>().add(AssetUploadEvent(filePath: filePath, imagePaths: [filePath]));
                                });
                              },
                            );
                          } else {
                            showError(context, "Image too big");
                          }
                        }
                      } else {
                        showAlertPermission(context,
                            text: "Allow Fansedu to access Gallery",
                            onTap: () => PermissionHelper.requestPhotoGalleryPermissionHelpers());
                      }
                    },
                    child: Ink(
                      color: Colors.white,
                      child: Row(
                        children: [
                          const Icon(Icons.image, color: ColorWidget.primaryColor).rightPadded(),
                          Flexible(
                              child: TextWidget.jakartaSansRegular("Choose from Gallery",
                                  size: 14, color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ).bottomPadded(),
              ],
            )
        )
    );
  }
}
