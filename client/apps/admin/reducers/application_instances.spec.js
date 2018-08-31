import * as ApplicationInstancesActions from '../actions/application_instances';
import applicationInstances from './application_instances';

describe('application_instances reducer', () => {
  describe('initial state', () => {
    it('returns empty state', () => {
      const initialState = {
        applicationInstances: {},
        totalPages: 1,
      };
      const state = applicationInstances(initialState, {});
      expect(state).toEqual({
        applicationInstances: {},
        totalPages: 1,
      });
    });
  });

  describe('update config', () => {
    it('makes a GET request for get application instances', () => {
      const applicationId = 1;
      const payloadId = 2;
      const state = undefined;
      const request = ApplicationInstancesActions.getApplicationInstances(applicationId);
      const config = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/application_instances`);

      const results = applicationInstances(state, {
        type: 'GET_APPLICATION_INSTANCES_DONE',
        payload: { application_instances: [{ config, id: payloadId }], total_pages: 1 }
      });
      expect(results.applicationInstances[payloadId].config).toBe(`${config}`);
      expect(results.applicationInstances[payloadId].id).toBe(payloadId);
    });
  });

  describe('update payload/config files', () => {
    it('makes a GET request for get application instance', () => {
      const applicationId = 1;
      const applicationInstanceId = 2;
      const payloadId = 3;
      const state = undefined;
      const request = ApplicationInstancesActions
        .getApplicationInstance(applicationId, applicationInstanceId);
      const config = 123;

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/application_instances/${applicationInstanceId}`);

      const results = applicationInstances(state, {
        type: 'GET_APPLICATION_INSTANCE_DONE',
        payload: { config, id: payloadId }
      });
      expect(results.applicationInstances[payloadId].config).toBe(`${config}`);
      expect(results.applicationInstances[payloadId].id).toBe(payloadId);
    });
  });

  describe('delete config', () => {
    it('makes a DELETE request for get application instances', () => {
      const applicationId = 1;
      const applicationInstanceId = 2;
      const state = undefined;
      const request = ApplicationInstancesActions
        .deleteApplicationInstance(applicationId, applicationInstanceId);

      expect(request).toBeDefined();
      expect(request.url).toBe(`/api/applications/${applicationId}/application_instances/${applicationInstanceId}`);

      const results = applicationInstances(state, {
        type: 'DELETE_APPLICATION_INSTANCE_DONE',
        original: { applicationInstanceId }
      });
      expect(results[applicationInstanceId]).not.toBeDefined();
    });
  });
});
