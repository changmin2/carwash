import 'package:carwash/common/const/sizes.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class TRoundedImage extends StatelessWidget {
  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  const TRoundedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.border,
    this.padding,
    this.onPressed,
    this.applyImageRadius = true,
    this.backgroundColor = Colors.white,
    this.fit = BoxFit.contain,
    this.isNetworkImage = false,
    this.borderRadius = TSizes.md,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
            child: isNetworkImage
            ?
            ExtendedImage.network(
              fit: fit,
              imageUrl,
              cache: true,
              loadStateChanged: (ExtendedImageState state){
                switch (state.extendedImageLoadState){
                  case LoadState.loading:
                    return Image.asset(
                      "asset/gif/loading.gif",
                      fit: fit,
                    );
                    break;
                  case LoadState.failed:
                    return Image.asset(
                      "asset/img/failed.png",
                      fit: fit,
                    );
                  break;
                }
              },
            )
            : Image(
              fit: fit,
              image: AssetImage(imageUrl) as ImageProvider,
            )

          ),
        ),
      ),
    );
  }
}
