import siteToOauth from './site_to_oauth';

describe('siteToOauth reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = siteToOauth(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('update site done', () => {
    it('returns payload url', () => {
      const state = {};
      const url = 'www.example.com';
      const result = siteToOauth(state, {
        type: 'UPDATE_SITE_DONE',
        payload: { url }
      });
      expect(result).toEqual(url);
    });
  });

  describe('create site done', () => {
    it('returns payload url', () => {
      const state = {};
      const url = 'www.example.com';
      const result = siteToOauth(state, {
        type: 'CREATE_SITE_DONE',
        payload: { url }
      });
      expect(result.url).toEqual(url);
    });
  });
});
