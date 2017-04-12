import * as ApplicationActions from '../actions/applications';
import applications from './applications';

describe('applications reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {};
      const state = applications(initialState, {});
      expect(state).toEqual({});
    });
  });

  describe('get applications', () => {
    it('makes a GET request for get applications', () => {
      const state = undefined;
      const request = ApplicationActions.getApplications();
      const config = 123;
      const appId = 1;

      expect(request).toBeDefined();
      expect(request.url).toBe('api/applications');


      const results = applications(state, {
        type: 'GET_APPLICATIONS_DONE',
        payload: [{ id: appId, default_config: config }]
      });
      expect(results[appId].default_config).toBe(`${config}`);
      expect(results[appId].id).toBe(appId);
    });
  });
});
