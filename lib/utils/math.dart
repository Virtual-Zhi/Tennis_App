import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

pickVideo() async {
  final picker = ImagePicker();
  XFile? videoFile;
  try {
    videoFile = await picker.pickVideo(source: ImageSource.gallery);
    return videoFile!.path;
  } catch (e) {
    print("Error Occured, Picking a video");
  }
}

String getfireBaseUser() {
  final User user = FirebaseAuth.instance.currentUser!;
  return user.uid;
}

