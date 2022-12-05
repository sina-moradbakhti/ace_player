import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback? onTapped;
  final String title;
  final Image? icon;
  final bool isLastItem;
  final bool hasSwitch;
  final bool switchOn;
  const SettingsItem(
      {super.key,
      required this.title,
      this.icon,
      this.onTapped,
      this.isLastItem = false,
      this.hasSwitch = false,
      this.switchOn = false});

  final double _ICON_SIZE = 22;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        decoration: !isLastItem
            ? BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.lightGrey)))
            : const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: hasSwitch
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: hasSwitch
                ? [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: _ICON_SIZE,
                          height: _ICON_SIZE,
                          child: icon ?? Container(),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          title,
                          style: AppTextStyles.normal
                              .copyWith(fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Switch(
                      value: switchOn,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onChanged: (_) {},
                    )
                  ]
                : [
                    SizedBox(
                      width: _ICON_SIZE,
                      height: _ICON_SIZE,
                      child: icon ?? Container(),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      title,
                      style: AppTextStyles.normal
                          .copyWith(fontWeight: FontWeight.w700),
                    )
                  ],
          ),
        ),
      ),
    );
  }
}
