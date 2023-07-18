part of 'image_picker_bloc.dart';

abstract class ImagePickerEvent extends Equatable {
  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class AddImageEvent extends ImagePickerEvent {
  File image;
  AddImageEvent(this.image);
}
