import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/shared_widgets/custom_loading_widget.dart';
import '../../../../core/utils/colors.dart';
import '../bloc/add_discussion_bloc/add_discussion_bloc.dart';
import 'top_snack_bar.dart';

Widget bottomTextField(
    String text,
    BuildContext context,
    TextEditingController commentTextEditingController,
    void Function()? onPressed) {
  return Container(
    
    decoration:  BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          blurRadius: 2,
          offset: const Offset(0, -6), // Move the shadow down
        ),
      ],
    ),
    // height: 8.h,
    width: MediaQuery.of(context).size.width,
    child: TextField(
      style: Theme.of(context).textTheme.bodyMedium,
      controller: commentTextEditingController,
      decoration: InputDecoration(
        // prefixIcon: Icon(Icons.add),
        suffixIcon: BlocConsumer<AddDiscussionBloc, AddDiscussionState>(
          listener: (context, state) {
            if (state is AddDiscussionSuccess) {
              showTopSnackBar(
                  context, TopSnackBar(message: "Successful", error: false));
            }
            if (state is AddDiscussionFailure) {
              showTopSnackBar(
                  context, TopSnackBar(message: "Failed", error: true));
            }
          },
          builder: (context, state) {
            if (state is AddDiscussionLoading) {
              return UniqueProgressIndicator(size: 25);
            }
            return IconButton(
              color: primaryColor,
              onPressed: onPressed,
              icon: Icon(
                Icons.send,
                size: 25,
              ),
            );
          },
        ),
        filled: true,
        fillColor: textFieldColor,
        hintText: text,
        hintStyle: Theme.of(context).textTheme.labelSmall,
        border: InputBorder.none,
      ),
    ),
  );
}
