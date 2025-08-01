import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../app/app.dart';

class CommonFilePicker extends StatefulWidget {
  final bool showLabel;
  final bool allowMultiple;
  final FileType type;
  final Widget? customWidget;
  final bool useCustomPicker;
  final bool addTimeStamp;
  final bool showCustomMediaPicker;
  final Function(List<PlatformFile> value) onSelectTap;

  const CommonFilePicker({
    super.key,
    this.showLabel = true,
    this.allowMultiple = true,
    this.type = FileType.any,
    this.customWidget,
    this.useCustomPicker = false,
    this.addTimeStamp = true,
    this.showCustomMediaPicker = false,
    required this.onSelectTap,
  });

  @override
  _CommonFilePickerState createState() => _CommonFilePickerState();
}

class _CommonFilePickerState extends State<CommonFilePicker> {
  List<PlatformFile> filesList = [];

  Future<PlatformFile?> convertXFileToPlatformFile({required XFile xFile, required bool isVideo}) async {
    String timeStamp = UtilsHelper.getDateTimeWithTimeZoneOffset();
    XFile? file;

    return PlatformFile(name: 'Test', size: 0);

    // try {
    //   context.showLoader();

    //   if (widget.addTimeStamp) {
    //     // Only add text if addText is true
    //     if (isVideo) {
    //       file = await ImageVideoManipulationHelper.addTextToVideo(xFile, timeStamp);
    //     } else {
    //       file = await ImageVideoManipulationHelper.addTextToImage(xFile, timeStamp);
    //     }
    //   } else {
    //     // Use original file if no text should be added
    //     file = xFile;
    //   }

    //   final bytes = await file.readAsBytes();

    //   return PlatformFile(
    //     name: file.name,
    //     path: file.path,
    //     size: bytes.length,
    //     bytes: bytes,
    //   );
    // } finally {
    //   context.hideLoader();
    // }
  }

  void pickMediaFromCamera([bool isVideo = false]) async {
    final ImagePicker picker = ImagePicker();
    final XFile? mediaFile = isVideo
        ? await picker.pickVideo(source: ImageSource.camera)
        : await picker.pickImage(
            source: ImageSource.camera,
            maxHeight: 1280,
            maxWidth: 960,
            imageQuality: 80,
          );
    if (mediaFile != null) {
      var result = await convertXFileToPlatformFile(isVideo: isVideo, xFile: mediaFile);
      if (result != null) {
        BottomSheetHelper.closeBottomSheet();
        filesList.add(result);
        setState(() {});
        widget.onSelectTap(filesList);
      }
    }
  }

  void openPickerBottomSheet() async {
    FocusScope.of(context).unfocus();
    BottomSheetHelper.showCommonBottomSheet(
      context,
      child: CommonBottomSheet(
        showHeader: false,
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPickerActionButton(
                context,
                icon: Icons.camera,
                label: AppTrKeys.camera.tr(context),
                onTap: () => openCameraPickerBottomSheet(),
              ),
              SizedBox(width: 16),
              buildPickerActionButton(
                context,
                icon: Icons.image,
                label: AppTrKeys.media.tr(context),
                onTap: () => openFilePicker(),
              ),
            ],
          )
        ],
      ),
    );
  }

  void openCameraPickerBottomSheet() {
    BottomSheetHelper.showCommonBottomSheet(
      context,
      child: CommonBottomSheet(
        showHeader: false,
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildPickerActionButton(
                context,
                icon: Icons.image,
                label: AppTrKeys.image.tr(context),
                onTap: () => pickMediaFromCamera(),
              ),
              SizedBox(width: 16),
              buildPickerActionButton(
                context,
                icon: Icons.videocam_rounded,
                label: AppTrKeys.video.tr(context),
                onTap: () => pickMediaFromCamera(true),
              ),
              if (widget.showCustomMediaPicker) ...[
                SizedBox(width: 16),
                buildPickerActionButton(
                  context,
                  icon: Icons.file_present_rounded,
                  label: AppTrKeys.media.tr(context),
                  onTap: () => openFilePicker(true),
                ),
              ]
            ],
          )
        ],
      ),
    );
  }

  void openFilePicker([bool isMediaPicker = false]) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: widget.allowMultiple,
      type: isMediaPicker ? FileType.media : widget.type,
    );

    if (widget.useCustomPicker) BottomSheetHelper.closeBottomSheet();

    if (result != null) {
      filesList.addAll(result.files);
      setState(() {});
      widget.onSelectTap(filesList);
    }
  }

  void removeFileFromList(PlatformFile file) {
    filesList.remove(file);
    setState(() {});
    widget.onSelectTap(filesList);
  }

  Widget buildCustomWidget() {
    return GestureDetector(
      onTap: widget.useCustomPicker ? openCameraPickerBottomSheet : openFilePicker,
      child: widget.customWidget,
    );
  }

  Widget buildHorizontalListViewBuilder() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (PlatformFile file in filesList)
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 62,
                    height: 62,
                  ),
                  GestureDetector(
                    onTap: () {
                      String type = UtilsHelper.getFileType(file.path);
                      
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      margin: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.gray.withOpacity(.25),
                        border: Border.all(
                          color: AppColors.gray.withOpacity(.25),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: UtilsHelper.getFileType(file.path) == 'image'
                            ? Image.file(
                                File(file.path ?? ''),
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.play_circle_filled_rounded),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CommonIcon(
                      Icons.close,
                      size: 14,
                      backgroundColor: AppColors.dangerDark,
                      color: AppColors.light,
                      onTap: () => removeFileFromList(file),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget buildVerticalListViewBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: filesList.length,
      itemBuilder: (context, index) {
        var file = filesList[index];
        return CommonCard(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  color: AppColors.gray.withOpacity(.1),
                  border: Border.all(
                    color: AppColors.gray.withOpacity(.25),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
                  child: widget.type == FileType.image
                      ? Image.file(
                          File(file.path ?? ''),
                          fit: BoxFit.cover,
                        )
                      : Icon(
                          Icons.file_present_rounded,
                          size: 20,
                        ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      file.name.split('.').first,
                      style: Theme.of(context).textTheme.tsRegular14,
                    ),
                    Text(
                      file.extension?.toUpperCase() ?? '',
                      style: Theme.of(context).textTheme.tsGrayMedium12,
                    ),
                  ],
                ),
              ),
              CommonIcon(
                Icons.close,
                size: 14,
                color: AppColors.danger,
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.only(right: 8),
                backgroundColor: AppColors.danger.withOpacity(.25),
                onTap: () => removeFileFromList(file),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.customWidget != null
        ? Row(
            children: [
              buildCustomWidget(),
              if (filesList.isNotEmpty) buildHorizontalListViewBuilder(),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (filesList.isNotEmpty) ...[
                if (widget.showLabel) ...[
                  Text(
                    AppTrKeys.files.tr(context),
                    style: Theme.of(context).textTheme.tsMedium14,
                  ),
                  SizedBox(height: 4),
                  buildVerticalListViewBuilder(),
                ],
              ],
              if ((widget.allowMultiple && filesList.isNotEmpty) || filesList.isEmpty)
                DottedBorder(
                  color: AppColors.gray.shade100,
                  borderType: BorderType.RRect,
                  radius: Radius.circular(AppTheme.buttonBorderRadius),
                  child: CommonCard(
                    borderRadius: BorderRadius.circular(AppTheme.buttonBorderRadius),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    backgroundColor: Colors.transparent,
                    child: Center(
                      child: Text(
                        AppTrKeys.selectYourFiles.tr(context),
                        style: Theme.of(context).textTheme.tsMedium14,
                      ),
                    ),
                    onTap: openFilePicker,
                  ),
                ),
            ],
          );
  }
}
