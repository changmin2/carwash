import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TUserProfileTile extends StatelessWidget {
  final String title, subtitle;

  const TUserProfileTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Image(
        image: AssetImage('asset/img/naver_logo.png'),
        width: 50,
        height: 50,
      ),
      title: Text(title, style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white)),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white)),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Iconsax.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}
