extension AntiBotStringExtension on String {

  /*
  *
  * Anti bot
  *  */

  String reCaptcha(String captcha) {
    return this.replaceAll("{captcha}", captcha);;
  }

  String reCaptchaAttempts(int attempts) {
    return this.replaceAll("{attempts}", attempts.toString());
  }

  String reLink(String link) {
    return this.replaceAll("{link}", link);;
  }
}

/*
*  {link}, {attemps}, {captcha}
*/