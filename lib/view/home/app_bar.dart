part of 'view.dart';

class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeAppBar();

  @override
  Size get preferredSize => Size.fromHeight(.1.sh);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
      child: Row(
        children: [
          Text(
            DataString.logo,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 24.w,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: (){
              GoRouter.of(context).go(AppRouter.rProfile);
            },
            child: const AppImage(
              path: DataAssets.profile,
              height: 24,
              width: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go(AppRouter.rLogIn);
            },
            child: const AppImage(
              path: DataAssets.logout,
              width: 24,
              height: 24,
              fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }
}
