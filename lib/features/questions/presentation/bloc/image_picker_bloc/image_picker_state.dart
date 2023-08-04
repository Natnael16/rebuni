part of 'image_picker_bloc.dart';

abstract class ImagePickerState extends Equatable {
  const ImagePickerState();

  @override
  List<Object> get props => [];
}

class ImagePickerInitial extends ImagePickerState {}

class ImageAddedState extends ImagePickerState {
  final File image;
  
  const ImageAddedState(this.image);

  @override
  List<Object> get props => [image];
}
