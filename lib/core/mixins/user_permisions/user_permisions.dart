import 'package:mvvm_architecture_template/core/permissions/enum/features_enum.dart';
import 'package:mvvm_architecture_template/core/permissions/enum/permission_actions_enum.dart';
import 'package:mvvm_architecture_template/core/permissions/enum/user_role_enum.dart';

mixin UserPermissionsMixin {
  final Map<FeatureEnum, List<PermissionActionsEnum>> _basicPermission = {
    FeatureEnum.test: PermissionActionsEnum.values,
  };
  UserRoleEnum get getUserRole => UserRoleEnum.getEnumByTitle(
        // Get.context
        //         ?.read<UserProfileCubit>()
        //         .userProfileEntity
        //         ?.role
        //         .roleName ??
        '',
      );

  bool get isAdmin => getUserRole == UserRoleEnum.admin;

  Map<FeatureEnum, List<PermissionActionsEnum>> getUserPermission() {
    if (getUserRole == UserRoleEnum.user) {
      return _basicPermission;
    }
    return _basicPermission;
  }
}
