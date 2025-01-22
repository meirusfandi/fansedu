const String serverProd = 'https://fansedu.meirusfandi.com/api/v1/';
const String serverDev = 'https://fansedu.meirusfandi.com/api/v1/';
const String imagesDev = 'https://fansedu.meirusfandi.com/images/';
const String imagesProd = 'https://fansedu.meirusfandi.com/images/';

enum TextFieldType {
  text,
  email,
  number,
  ktp,
  phone,
  date,
  options,
  time,
  password,
  multiline
}

enum TextFieldBorderType { filled, outlined }

enum AnalyticEventType {
  homepage_viewed,
}
