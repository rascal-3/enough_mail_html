import 'package:enough_mail/enough_mail.dart';
import 'package:enough_mail_html/enough_mail_html.dart';
import 'package:html/dom.dart';

String simpleTransformExample(MimeMessage mimeMessage) =>
    mimeMessage.transformToHtml();

String generatePlainText(String htmlText) =>
    HtmlToPlainTextConverter.convert(htmlText);

String configureImageBlockingOrEmptyMessage(MimeMessage mimeMessage) =>
    mimeMessage.transformToHtml(
      blockExternalImages: true,
      emptyMessageText: 'Nothing here, move on!',
    );

Future<String> playYourself(MimeMessage mimeMessage) async {
  final cfg = TransformConfiguration.create(
    blockExternalImages: true,
    emptyMessageText: 'Nothing here, move on!',
    customDomTransformers: [StyleTextDomTransformer()],
    customValues: {'textStyle': 'font-size:10px;font-family:verdana;'},
  );
  return mimeMessage.transformToHtml(transformConfiguration: cfg);
}

class StyleTextDomTransformer extends DomTransformer {
  @override
  void process(Document document, MimeMessage message,
      TransformConfiguration configuration) {
    final paragraphs = document.getElementsByTagName('p');
    for (final paragraph in paragraphs) {
      paragraph.attributes['style'] = configuration.customValues!['textStyle'];
    }
  }
}
