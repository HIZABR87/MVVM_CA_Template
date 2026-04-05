enum UserRoleEnum {
  admin('admin'),
  user('user'),
  ;

  const UserRoleEnum(this.title);

  final String title;

  static UserRoleEnum getEnumByTitle(String title) {
    var lowerCaseTitle = title.toLowerCase();
    switch (lowerCaseTitle) {
      case 'admin':
        return UserRoleEnum.admin;
      case 'user':
        return UserRoleEnum.user;
      default:
        return UserRoleEnum.user;
    }
  }
}
