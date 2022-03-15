part of 'post_cubit.dart';

class PostState {
  String dropVal;
  List<String> dropList;
  List<String>? images;
  List<String>? showImages;
  double initChildSize;
  List<Widget> bottomSheetWidgets;
  String? postBGImage;
  TextEditingController postController;
  TextEditingController textController;
  TextStyle captionTextStyle;
  Uint8List? videoFile;
  Uint8List? showVideoFile;
  PlaceNearby? places;
  String? currentPlace;
  String? videoFilePath;
  VideoPlayerController? videoController;
  Duration? videoTotalDuration = Duration();
  Duration? videoProgress = Duration();
  bool? isVideoLoading = true;
  bool? isUploaded;
  bool? isUploadingPost = false;
  String? showText;


  PostState(
      {required this.dropList,
      required this.dropVal,
      this.images,
      required this.initChildSize,
      required this.bottomSheetWidgets,
      this.postBGImage,
      required this.postController,
      required this.captionTextStyle,
      this.videoFile,
        this.places,
        this.currentPlace,
        required this.textController,
        this.videoFilePath,
        this.videoController,
        this.isVideoLoading,
        this.videoProgress,
        this.videoTotalDuration,
        this.isUploaded,
        this.isUploadingPost,
        this.showImages,
        this.showText,
        this.showVideoFile
      });

  PostState copyWith({
    String? dropVall,
    List<String>? imagese,
    List<String>? showImagess,
    double? initChildSizee,
    List<Widget>? bottomSheetWidget,
    String? postBGImagee,
    TextStyle? captionTextStylee,
    Uint8List? videoFil,
    PlaceNearby? placess,
    String? currentPlacee,
    TextEditingController? textControllerr,
    TextEditingController? postControllerr,
    String? videoFilePathh,
    VideoPlayerController? videoControllerr,
    Duration? videoTotalDurationn,
    Duration? videoProgresss,
    bool? isVideoLoadingg,
    bool? isUplaodeed,
    bool? isUploadingPostt,
    String? showTextt,
    Uint8List? showVideoFilee
  }) {
    return PostState(
      postBGImage: postBGImagee ?? postBGImage,
      initChildSize: initChildSizee ?? initChildSize,
      images: imagese ?? images,
      dropList: dropList,
      dropVal: dropVall ?? dropVal,
      bottomSheetWidgets: bottomSheetWidget ?? bottomSheetWidgets,
      postController: postControllerr ?? postController,
      captionTextStyle: captionTextStylee ?? captionTextStyle,
      videoFile: videoFil ?? videoFile,
      places: placess ?? places,
      currentPlace: currentPlacee ?? currentPlace,
      textController: textControllerr ?? textController,
      videoFilePath: videoFilePathh ?? videoFilePath,
      videoController: videoControllerr ?? videoController,
      isVideoLoading: isVideoLoadingg ?? isVideoLoading,
      videoProgress: videoProgresss ?? videoProgress,
      videoTotalDuration: videoTotalDurationn ?? videoTotalDuration,
      isUploaded: isUplaodeed ?? isUploaded,
      isUploadingPost: isUploadingPostt ?? isUploadingPost,
      showImages: showImagess ?? showImages,
      showText: showTextt ?? showText,
      showVideoFile: showVideoFilee ?? showVideoFile
    );
  }
}
