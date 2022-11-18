import getExtraFields from './extra_fields';

describe('getExtraFields', () => {
  it('returns an empty array', () => {
    const result = getExtraFields('');
    expect(result).toEqual([]);
  });
  it('returns an array with one empty object in it', () => {
    const result = getExtraFields('search');
    expect(result).toEqual([{}]);
  });
});
