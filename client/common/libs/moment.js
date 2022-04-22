import moment from 'moment-timezone';

export function initMomentJS(languages, timezone) {
  if (timezone) {
    moment.tz.setDefault(timezone);
  }
  moment.locale(languages);
}
