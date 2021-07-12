
export default function getExtraFields(appKey) {
  if (appKey === 'search' || appKey === 'navigator') {
    return [{

    }];
  }
  return [];
}
