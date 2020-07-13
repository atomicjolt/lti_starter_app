import _ from 'lodash';
import * as LtiInstallKeyActions from '../actions/lti_install_keys';
import ltiInstallKeys from './lti_install_keys';

describe('lti_install_keys reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {
        ltiInstallKeys: [],
        totalPages: 1,
      };
      const state = ltiInstallKeys(initialState, []);
      expect(state).toEqual({
        ltiInstallKeys: [],
        totalPages: 1,
      });
    });
  });

  describe('update clientId', () => {
    it('makes a GET request for get lti install keys', () => {
      const applicationId = 1;
      const payloadId = 2;
      const state = undefined;
      const request = LtiInstallKeyActions.getLtiInstallKeys(applicationId);
      const clientId = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/lti_install_keys`);

      const results = ltiInstallKeys(state, {
        type: 'GET_LTI_INSTALL_KEYS_DONE',
        payload: { lti_install_keys: [{ client_id: `${clientId}`, id: payloadId }], total_pages: 1 }
      });
      const ltiInstallKey = _.find(results.ltiInstallKeys, ltiInstall => (
        `${ltiInstall.id}` === `${payloadId}`
      ));
      expect(ltiInstallKey.clientId).toBe(`${clientId}`);
      expect(ltiInstallKey.id).toBe(payloadId);
    });
  });

  describe('update payload/config files', () => {
    it('makes a GET request for get lti install key', () => {
      const applicationId = 1;
      const ltiInstallKeyId = 2;
      const payloadId = 3;
      const state = undefined;
      const request = LtiInstallKeyActions
        .getLtiInstallKey(applicationId, ltiInstallKeyId);

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/lti_install_keys/${ltiInstallKeyId}`);

      const results = ltiInstallKeys(state, {
        type: 'GET_LTI_INSTALL_KEY_DONE',
        payload: { id: payloadId }
      });
      const ltiInstallKey = _.find(results.ltiInstallKeys, ltiInstall => (
        `${ltiInstall.id}` === `${payloadId}`
      ));
      expect(ltiInstallKey.id).toBe(payloadId);
    });
  });

  describe('delete lti install key', () => {
    it('makes a DELETE request for lti install keys', () => {
      const applicationId = 1;
      const ltiInstallKeyId = 2;
      const state = undefined;
      const request = LtiInstallKeyActions
        .deleteLtiInstallKey(applicationId, ltiInstallKeyId);

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/lti_install_keys/${ltiInstallKeyId}`);

      const results = ltiInstallKeys(state, {
        type: 'DELETE_LTI_INSTALL_KEY_DONE',
        original: { ltiInstallKeyId }
      });
      const ltiInstallKey = _.find(results.ltiInstallKeys, ltiInstall => (
        `${ltiInstall.id}` === `${ltiInstallKeyId}`
      ));
      expect(ltiInstallKey).not.toBeDefined();
    });
  });
});
