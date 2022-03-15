import 'package:image_picker/image_picker.dart';

class PublicLogics{

  getImage()async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image;
  }

}