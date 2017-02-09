import _ from 'lodash';

export function getNextUrl(link) {
  if (link) {
    const url = _.find(link.split(','), (l) => {
      const val = _.trim(l.split(';')[1]);
      return val === 'rel="next"';
    });
    if (url) {
      return url.split(';')[0].replace(/[<>\s]/g, '');
    }
  }
  return null;
}

export function parseParams(url) {
  const parts = url.split('?');
  if (parts.length > 1) {
    return _.reduce(parts[1].split('&'), (params, pair) => ({
      ...params,
      [pair.split('=')[0]]: pair.split('=')[1]
    }), {});
  }
  return undefined;
}
