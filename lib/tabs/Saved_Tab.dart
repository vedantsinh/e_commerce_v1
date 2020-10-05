import 'package:e_commers_v1/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [

          Center(
            child: Text("Saved tab"),
          ),

          CustomActionBar(
            title: "Saved",
            hasTitle: false,
            hasBackArrow: true,
          ),
        ],
      ),
    );
  }
}
