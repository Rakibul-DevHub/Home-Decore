enum AccountActionKind { deactivate, delete }

enum AccountResultKind { deletionRequested, deactivated, reactivated }

abstract final class DeactivateAccountData {
  static const hubAppBarTitle = 'Deactivate or Delete Account';
  static const hubTitle = 'Deactivate or Delete Account';
  static const hubBody =
      'You can temporarily deactivate your account or permanently delete it.';

  static const deactivateTitle = 'Deactivate Account';
  static const deactivateBody =
      'Temporarily hide your profile and activity until you return.';

  static const deleteTitle = 'Delete Account';
  static const deleteBody =
      'Permanently delete your Kolek account and associated information.';

  static const helpPrompt = 'Need help with your account?';
  static const supportEmail = 'help@kolek.io';

  static const deactivateAppBarTitle = 'Deactivate Account';
  static const deactivateConfirmTitle = 'Deactivate your account?';
  static const deactivateConfirmBody =
      'Your profile and content will be hidden while your account is deactivated. You can return to Kolek by signing back in.';
  static const deactivateConfirmNote =
      'Certain information may be retained where necessary for completed transactions, legal obligations, security, and other legitimate purposes.';
  static const deactivateConfirmAction = 'Deactivate Account';
  static const cancel = 'Cancel';

  static const deleteAppBarTitle = 'Delete Account';
  static const deleteConfirmTitle = 'Delete your account?';
  static const deleteConfirmLead = 'Deleting your Kolek account is permanent.';
  static const thisWillRemove = 'This will remove:';
  static const beforeYouCanDelete = 'Before you can delete your account';
  static const beforeYouCanDeleteLead =
      'You may need to complete or resolve certain activity before deletion, such as:';
  static const pendingNote =
      "You won't be able to delete your account while these are pending.";
  static const continueToDelete = 'Continue to Delete';

  static const removalItems = [
    'Profile',
    'Posts',
    'Saved Items',
    'Followers and following',
    'Listings',
    'Other account information associated with Kolek',
  ];

  static const pendingItems = [
    'Profile',
    'Posts',
    'Saved Items',
    'Followers and following',
    'Listings',
    'Other account information associated with Kolek',
  ];

  static const passwordTitle = 'Permanently delete account?';
  static const passwordSubtitle = 'This action cannot be undone.';
  static const passwordLabel = 'To Confirm, Enter Your Password';
  static const passwordHint = 'Password';
  static const permanentlyDelete = 'Permanently Delete Account';
  static const demoPassword = 'password';

  static const deletionRequestedTitle = 'Account deletion requested';
  static const deletionRequestedBody =
      "We've received your request to permanently delete your Kolek account.";
  static const deletionRequestedNote =
      'If you have any active transactions, payouts, or disputes, we will complete or resolve them before your account is removed.';
  static const deletionRequestedFooter =
      "You'll receive an email once the deletion is complete.";

  static const deactivatedTitle = 'Your account is deactivated';
  static const deactivatedBody =
      'Your profile and content are hidden while your account is deactivated.';
  static const deactivatedFooter =
      'You can return to Kolek anytime by signing back in.';

  static const reactivatedTitle = 'Welcome back!';
  static const reactivatedBody = 'Your account has been reactivated.';
  static const reactivatedFooter =
      'Your profile and content are visible again.';

  static const done = 'Done';
}
