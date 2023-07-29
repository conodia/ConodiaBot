import 'utils/embed_entity_message.dart';

class AntiBotEntityMessage {

  final EmbedEntityMessage setup;
  final EmbedEntityMessage alreadyVerify;
  final EmbedEntityMessage captchaWrong;
  final EmbedEntityMessage captchaSuccess;
  final EmbedEntityMessage botKick;
  final EmbedEntityMessage botBan;
  final EmbedEntityMessage link;
  final EmbedEntityMessage linkSuccess;
  final EmbedEntityMessage sendUser;

  final String captchaModalLabel;

  AntiBotEntityMessage({
    required EmbedEntityMessage this.setup,
    required EmbedEntityMessage this.alreadyVerify,
    required EmbedEntityMessage this.captchaWrong,
    required EmbedEntityMessage this.captchaSuccess,
    required EmbedEntityMessage this.botKick,
    required EmbedEntityMessage this.botBan,
    required EmbedEntityMessage this.link,
    required EmbedEntityMessage this.linkSuccess,
    required EmbedEntityMessage this.sendUser,
    required this.captchaModalLabel,
});

  factory AntiBotEntityMessage.from({required dynamic payload}) {
    return AntiBotEntityMessage(
        setup: EmbedEntityMessage(title: payload['setup']['title'], description: payload['setup']['description']),
        alreadyVerify: EmbedEntityMessage(title: payload['already_verify']['title'], description: payload['already_verify']['description']),
        captchaWrong: EmbedEntityMessage(title: payload['captcha']['wrong']['title'], description: payload['captcha']['wrong']['description']),
        captchaSuccess: EmbedEntityMessage(title: payload['captcha']['success']['title'], description: payload['captcha']['success']['description']),
        botKick: EmbedEntityMessage(title: payload['bot']['kick']['title'], description: payload['bot']['kick']['description']),
        botBan: EmbedEntityMessage(title: payload['bot']['ban']['title'], description: payload['bot']['ban']['description']),
        link: EmbedEntityMessage(title: payload['link']['title'], description: payload['link']['description'], button: payload['link']['button']),
        linkSuccess: EmbedEntityMessage(title: payload['link']['success']['title'], description: payload['link']['success']['description']),
        sendUser: EmbedEntityMessage(title: payload['send_user']['title'], description: payload['send_user']['description']),
        captchaModalLabel: payload['captcha']['modal']['label']);
  }
}
