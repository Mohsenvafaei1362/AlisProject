import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ImageLoadingService extends StatelessWidget {
  final String imageUrl;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final BoxFit? boxfit;
  const ImageLoadingService({
    Key? key,
    required this.imageUrl,
    this.borderRadius,
    this.height,
    this.width,
    this.boxfit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget image = CachedNetworkImage(
      placeholder: (context, url) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CupertinoActivityIndicator(),
        ],
      ),
      imageUrl: imageUrl,
      fit: boxfit,
      width: width,
      height: height,
    );
    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius, child: image);
    } else {
      return image;
    }
  }
}
