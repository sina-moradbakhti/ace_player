import 'package:ace_player/configs.dart';
import 'package:flutter/material.dart';

class PlayListItem extends StatelessWidget {
  final String item;
  const PlayListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
          color: AppColors.lightGrey,
          border: Border.all(width: 1, color: AppColors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: -10,
            child: Transform.rotate(
                angle: -0.35,
                child: Text(
                  item,
                  style: AppTextStyles.headline1.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGrey.withOpacity(0.2),
                      letterSpacing: -1,
                      fontSize: 60),
                )),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('0',
                      style: AppTextStyles.headline4.copyWith(
                          color: AppColors.darkGrey.withOpacity(0.3),
                          fontSize: 45,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Text('Songs',
                        style: AppTextStyles.caption2
                            .copyWith(color: AppColors.darkGrey)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
