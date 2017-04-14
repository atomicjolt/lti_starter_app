import * as SitesActions from '../actions/sites';
import sites from './sites';

describe('sites reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = sites(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('get sites done', () => {
    it('makes a GET request for get sites', () => {
      const state = undefined;
      const request = SitesActions.getSites();
      const appId = 1;
      const config = 123;
      const appId2 = 2;
      const config2 = 124;

      expect(request).toBeDefined();
      expect(request.url).toBe('api/sites');

      const results = sites(state, { type: 'GET_SITES_DONE', payload: [{ id: appId, config }, { id: appId2, config: config2 }] });
      expect(results[appId].id).toBe(appId);
      expect(results[appId].config).toBe(config);
      expect(results[appId2].id).toBe(appId2);
      expect(results[appId2].config).toBe(config2);
    });
  });

  describe('create site', () => {
    it('makes a CREATE request for sites', () => {
      const state = undefined;
      const site = { id: 1 };
      const request = SitesActions.createSite(site);
      const appId = 1;
      const config = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe('api/sites');

      const results = sites(state, { type: 'CREATE_SITE_DONE', payload: { id: appId, config } });
      expect(results[appId].id).toBe(appId);
      expect(results[appId].config).toBe(config);
    });
  });

  describe('update site', () => {
    it('makes a UPDATE request for sites', () => {
      const state = undefined;
      const site = { id: 1 };
      const request = SitesActions.updateSite(site);
      const config = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe(`api/sites/${site.id}`);

      const results = sites(state, { type: 'UPDATE_SITE_DONE', payload: { id: site.id, config } });
      expect(results[site.id].id).toBe(site.id);
      expect(results[site.id].config).toBe(config);
    });
  });

  describe('delete site', () => {
    it('makes a DELETE request for sites', () => {
      const state = undefined;
      const siteId = 1;
      const request = SitesActions.deleteSite(siteId);
      const config = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe(`api/sites/${siteId}`);

      const results = sites(state, { type: 'DELETE_SITE_DONE', original: { id: siteId, config } });
      expect(results[siteId]).not.toBeDefined();
    });
  });
});
