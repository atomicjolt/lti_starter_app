import _ from 'lodash';
import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_APPLICATIONS',
  'SAVE_APPLICATION',
];

export const Constants = wrapper(actions, requests);

export function getApplications() {
  return {
    type   : Constants.GET_APPLICATIONS,
    method : Network.GET,
    url    : 'api/applications',
  };
}

export function saveApplication(application) {
  const applicationClone = _.cloneDeep(application);
  applicationClone.default_config = JSON.parse(application.default_config || '{}');
  return {
    type   : Constants.SAVE_APPLICATION,
    method : Network.PUT,
    url    : `api/applications/${application.id}`,
    body   : {
      application: applicationClone
    }
  };
}
