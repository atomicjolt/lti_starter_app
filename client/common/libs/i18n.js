import i18next from 'i18next';
import { initReactI18next } from 'react-i18next';

export async function initLocalization(components, language, defaultLanguage, i18n = i18next) {
  await i18n
    .use(initReactI18next) // passes i18n down to react-i18next
    .init({
      fallbackLng: [defaultLanguage, 'en'],
      lng: language,

      keySeparator: false, // we do not use keys in form messages.welcome
      nsSeparator: false, // allow colons

      interpolation: {
        escapeValue: false // react already safes from xss
      }
    });

  const languages = [...new Set([language])];
  const promises = [];
  languages.forEach((lng) => {
    components.forEach((component) => {
      promises.push(
        import(`../../locales/${lng}/${component}.json`).then((resource) => {
          i18n.addResourceBundle(lng, 'translation', resource.default.translation, true, true);
          i18n.addResourceBundle(lng, 'locale', resource.default.locale, true, true);
        }).catch((reason) => false) // Ignore loading errors, since we don't know if the languages exist on our end
      );
    });
  });

  document.getElementsByTagName('body')[0].style.direction = i18n.dir(i18n.language);

  await Promise.all(promises);

}
