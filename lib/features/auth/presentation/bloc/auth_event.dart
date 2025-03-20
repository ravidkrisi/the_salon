abstract class AuthEvent {}

// sign in with google
class AuthSignInWithGoogle extends AuthEvent {}

// get current user
class AuthCheckAuth extends AuthEvent {}

// logout
class AuthLogout extends AuthEvent {}
