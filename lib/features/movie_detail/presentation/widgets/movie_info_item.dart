part of 'widgets.dart';

class MovieInfoItem extends StatelessWidget {
  final String label;
  final IconData icon;

  const MovieInfoItem({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    const Color mainColor = Color(0xFF92929D);
    return Row(
      children: [
        Icon(
          icon,
          color: mainColor,
          size: 18,
        ),
        AppUtils.kGap4,
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: mainColor,
          ),
        ),
      ],
    );
  }
}
