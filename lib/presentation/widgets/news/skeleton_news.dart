import 'package:flutter/material.dart';


class SkeletonNews extends StatelessWidget {
  const SkeletonNews({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        _SkeletonArticle(),
        SizedBox(height: 20),
        _SkeletonSecondaryArticle(),
        SizedBox(height: 20),
        _SkeletonArticle(),
      ],
    );
  }
}


class _SkeletonArticle extends StatelessWidget {
  const _SkeletonArticle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _SkeletonBox(
                height: 180,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                _SkeletonBox(
                  height: 12,
                  width: 120,
                ),
                SizedBox(height: 8),

                _SkeletonBox(
                  height: 16,
                  width: double.infinity,
                ),
                SizedBox(height: 6),

                _SkeletonBox(
                  height: 16,
                  width: 220,
                ),
                SizedBox(height: 10),

                _SkeletonBox(
                  height: 12,
                  width: 140,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonSecondaryArticle extends StatelessWidget {
  const _SkeletonSecondaryArticle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 22,
        right: 22,
        top: 16,
        bottom: 6,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonBox(
                      height: 12,
                      width: 100,
                    ),
                    SizedBox(height: 8),

                    _SkeletonBox(
                      height: 16,
                      width: double.infinity,
                    ),
                    SizedBox(height: 6),

                    _SkeletonBox(
                      height: 16,
                      width: 180,
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const _SkeletonBox(
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          const Align(
            alignment: Alignment.centerLeft,
            child: _SkeletonBox(
              height: 12,
              width: 140,
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double height;
  final double width;

  const _SkeletonBox({
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.grey.shade500,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}

