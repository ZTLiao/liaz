import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:liaz/app/constants/app_style.dart';

class NetImage extends StatefulWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double borderRadius;
  final bool progress;

  final Widget _default = Container(
    decoration: BoxDecoration(
      color: Colors.grey.withOpacity(.1),
    ),
    child: const Icon(
      Icons.image,
      color: Colors.grey,
      size: 24,
    ),
  );

  NetImage(this.url,
      {this.width,
      this.height,
      this.fit = BoxFit.cover,
      this.borderRadius = 0,
      this.progress = false,
      super.key});

  @override
  State<StatefulWidget> createState() => _NetImageState();
}

class _NetImageState extends State<NetImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var url = widget.url;
    if (url.isEmpty) {
      return widget._default;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: ExtendedImage.network(
        url,
        fit: widget.fit,
        height: widget.height,
        width: widget.width,
        shape: BoxShape.rectangle,
        handleLoadingProgress: widget.progress,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        loadStateChanged: (e) {
          if (e.extendedImageLoadState == LoadState.loading) {
            animationController.reset();
            final double? progress =
                e.loadingProgress?.expectedTotalBytes != null
                    ? e.loadingProgress!.cumulativeBytesLoaded /
                        e.loadingProgress!.expectedTotalBytes!
                    : null;
            if (widget.progress) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                    ),
                    AppStyle.vGap4,
                    Text(
                      '${((progress ?? 0.0) * 100).toInt()}%',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              );
            }
            return widget._default;
          } else if (e.extendedImageLoadState == LoadState.failed) {
            animationController.reset();
            return widget._default;
          } else if (e.extendedImageLoadState == LoadState.completed) {
            if (e.wasSynchronouslyLoaded) {
              return e.completedWidget;
            }
            animationController.forward();
            return FadeTransition(
              opacity: animationController,
              child: e.completedWidget,
            );
          }
          return null;
        },
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
