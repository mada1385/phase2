import 'package:gulfgoal/I10n/messages_all.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get contactus => Intl.message('Contact us', name: 'contactus');
  String get gethelp =>
      Intl.message('Get help and support or get in touch', name: 'gethelp');
  String get socialMedia => Intl.message('Social Media', name: 'socialMedia');
  String get search => Intl.message('Search', name: 'search');
  String get choosefavcountry =>
      Intl.message('Choose your favourite country', name: 'choosefavcountry');
  String get selectfavcountry =>
      Intl.message('select your country', name: 'selectfavcountry');
  String get nomatchestoday =>
      Intl.message('No matches today!', name: 'nomatchestoday');
  String get favouriteClubs =>
      Intl.message('Favourite Clubs', name: 'favouriteClubs');
  String get forgetpassword =>
      Intl.message('Forget password', name: 'forgetpassword');
  String get sendemail =>
      Intl.message('We will send your password to your email',
          name: 'sendemail');
  String get writeyourEmail =>
      Intl.message('Write your Email', name: 'writeyourEmail');
  String get email => Intl.message('Email', name: 'email');
  String get sendpassword =>
      Intl.message('Send password', name: 'sendpassword');
  String get yourTeam => Intl.message('Your Team', name: 'yourTeam');
  String get latestNews => Intl.message('Latest News', name: 'latestNews');
  String get home => Intl.message('Home', name: 'home');
  String get games => Intl.message('Games', name: 'games');
  String get news => Intl.message('News', name: 'news');
  String get favourites => Intl.message('Favourites', name: 'favourites');
  String get profile => Intl.message('Profile', name: 'profile');
  String get favouriteleague =>
      Intl.message('Choose your favourite league', name: 'favouriteleague');
  String get selectleague =>
      Intl.message('select your league', name: 'selectleague');
  String get fixtures => Intl.message('Fixtures', name: 'fixtures');
  String get table => Intl.message('Table', name: 'table');
  String get formation => Intl.message('Formation', name: 'formation');
  String get nocommentsye =>
      Intl.message('No comments yet !', name: 'nocommentsye');
  String get youmustregister =>
      Intl.message('You must register first', name: 'youmustregister');
  String get likes => Intl.message('likes', name: 'likes');
  String get reply => Intl.message('Reply', name: 'reply');
  String get stats => Intl.message('Stats', name: 'stats');
  String get facts => Intl.message('Facts', name: 'facts');
  String get lineup => Intl.message('Line up', name: 'lineup');
  String get chat => Intl.message('Chat', name: 'chat');
  String get relatedNews => Intl.message('Related News', name: 'relatedNews');
  String get trendingNews =>
      Intl.message('Trending News', name: 'trendingNews');
  String get pushNotifications =>
      Intl.message('Push Notifications', name: 'pushNotifications');
  String get companyprofile =>
      Intl.message('Company profile', name: 'companyprofile');
  String get termsofServices =>
      Intl.message('Terms of Services', name: 'termsofServices');
  String get privacypolicy =>
      Intl.message('Privacy policy', name: 'privacypolicy');
  String get shareGulfGoal =>
      Intl.message('Share Gulf Goal', name: 'shareGulfGoal');
  String get letsresume =>
      Intl.message('Let\'s resume where you left off!', name: 'letsresume');
  String get logintocontinue =>
      Intl.message('Login to continue"', name: 'logintocontinue');
  String get writeyourpassword =>
      Intl.message('Write your password', name: 'writeyourpassword');
  String get password => Intl.message('Password', name: 'password');
  String get forgetypurpassword =>
      Intl.message('Forget your password ?', name: 'forgetypurpassword');
  String get clickhere => Intl.message('Click here', name: 'clickhere');
  String get donthaveanaccount =>
      Intl.message('Don\'t have an account ?', name: 'donthaveanaccount');
  String get createanaccount =>
      Intl.message('Create an account', name: 'createanaccount');
  String get login => Intl.message('Login', name: 'login');
  String get letsgetstarted =>
      Intl.message('lets get started', name: 'letsgetstarted');
  String get createanaccounttocontinue =>
      Intl.message('Create an account to continue',
          name: 'createanaccounttocontinue');
  String get writeyourusername =>
      Intl.message('Write your username', name: 'writeyourusername');
  String get username => Intl.message('Username', name: 'username');
  String get confirmyourpassword =>
      Intl.message('Confirm your password', name: 'confirmyourpassword');
  String get confirmpassword =>
      Intl.message('confirmpassword', name: 'confirmpassword');
  String get passwordsdonotmatch =>
      Intl.message('passwords do not match', name: 'passwordsdonotmatch');
  String get bycreatinganaccountyouagreetoour =>
      Intl.message('By creating an account you agree to our T&C',
          name: 'bycreatinganaccountyouagreetoour');
  String get alreadyhaveanaccount =>
      Intl.message('Already have an account ?', name: 'alreadyhaveanaccount');
  String get createAccount =>
      Intl.message('Create Account', name: 'createAccount');
  String get chooseyourfavouriteteams =>
      Intl.message('Choose your favourite teams',
          name: 'chooseyourfavouriteteams');
  String get selectyourteams =>
      Intl.message('select your teams', name: 'selectyourteams');
  String get successful => Intl.message('successful', name: 'successful');
  String get somethingwentwrong =>
      Intl.message('something went wrong', name: 'somethingwentwrong');
  String get addacomment => Intl.message(' add a comment', name: 'addacomment');
  String get addareply => Intl.message('add a reply', name: 'addareply');
  String get signin => Intl.message('Sign in', name: 'signin');
  String get signup => Intl.message('Sign up', name: 'signup');
  String get pleasesignintocontinue =>
      Intl.message('Please sign in to continue',
          name: 'pleasesignintocontinue');
  String get allcategories =>
      Intl.message('All categories', name: 'allcategories');
  String get favourite => Intl.message('★  Favourite', name: 'favourite');
  String get allgames => Intl.message('All games', name: 'allgames');
  String get emailisnotvalid =>
      Intl.message('email is not valid', name: 'emailisnotvalid');

  String get thisfieldisrequired =>
      Intl.message('this field is required', name: 'thisfieldisrequired');
  String get passeordcontain =>
      Intl.message('Password must contain at least 8 digits',
          name: 'passeordcontain');
  String get mailnotvalid =>
      Intl.message('Password must contain at least one special character',
          name: 'mailnotvalid');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}
