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
        payload: {
          url,
          oauth_key: '12341432142431',
          oauth_secret: '135iajfp95j143pj'
        }
      });
      expect(result.url).toEqual(url);
    });
  });

  describe('create site done', () => {
    it('returns payload url', () => {
      const state = {};
      const url = 'www.example.com';
      const result = siteToOauth(state, {
        type: 'CREATE_SITE_DONE',
        payload: {
          url,
          oauth_key: '12341432142431',
          oauth_secret: '135iajfp95j143pj'
        }
      });
      expect(result.url).toEqual(url);
    });
  });
});
