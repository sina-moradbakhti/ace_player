import 'package:ace_player/components/loading.widget.dart';
import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class BottomSheetItemButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback? onTapped;
  final bool loading;
  const BottomSheetItemButton(
      {super.key,
      required this.icon,
      required this.title,
      this.onTapped,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTapped,
      child: Opacity(
        opacity: onTapped != null ? 1 : 0.4,
        child: Row(
          children: [
            icon,
            const SizedBox(width: 15),
            Text(
              title,
              style: AppTextStyles.caption1,
            ),
            if (loading)
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: MyLoading(size: 15, stroke: 2),
              )
          ],
        ),
      ),
    );
  }
}
