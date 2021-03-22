import CatalystLink from './catalyst_link';

export default function getExtraFields(appKey) {
  if (appKey === 'search' || appKey === 'navigator') {
    return [{
      name: 'Catalyst Stats',
      Component: CatalystLink,
    }];
  }
  return [];
}
