import wrapper from 'atomic-fuel/libs/constants/wrapper';
import Network from 'atomic-fuel/libs/constants/network';

// Local actions
const actions = [];

// Actions that make an api request
const requests = [
  'GET_LTI_INSTALL_KEYS',
  'GET_LTI_INSTALL_KEY',
  'CREATE_LTI_INSTALL_KEY',
  'DELETE_LTI_INSTALL_KEY',
  'SAVE_LTI_INSTALL_KEY',
];

const translateLtiInstallKey = function(ltiInstallKey) {
  return {
    iss: ltiInstallKey.iss,
    client_id: ltiInstallKey.clientId,
    jwks_url: ltiInstallKey.jwksUrl,
    token_url: ltiInstallKey.tokenUrl,
    oidc_url: ltiInstallKey.oidcUrl,
  };
};

export const Constants = wrapper(actions, requests);

export function getLtiInstallKeys(applicationId, page, column, direction) {
  return {
    type: Constants.GET_LTI_INSTALL_KEYS,
    method: Network.GET,
    url: `/api/applications/${applicationId}/lti_install_keys`,
    params: {
      page,
      column,
      direction,
    }
  };
}

export function getLtiInstallKey(applicationId, ltiInstallKeyId) {
  return {
    type: Constants.GET_LTI_INSTALL_KEY,
    method: Network.GET,
    url: `/api/applications/${applicationId}/lti_install_keys/${ltiInstallKeyId}`,
  };
}

export function createLtiInstallKey(applicationId, ltiInstallKey) {
  return {
    type: Constants.CREATE_LTI_INSTALL_KEY,
    method: Network.POST,
    url: `/api/applications/${applicationId}/lti_install_keys`,
    body: {
      lti_install: translateLtiInstallKey(ltiInstallKey),
    }
  };
}

export function saveLtiInstallKey(applicationId, ltiInstallKey) {
  return {
    type: Constants.SAVE_LTI_INSTALL_KEY,
    method: Network.PUT,
    url: `/api/applications/${applicationId}/lti_install_keys/${ltiInstallKey.id}`,
    body: {
      lti_install: translateLtiInstallKey(ltiInstallKey),
    }
  };
}

export function deleteLtiInstallKey(applicationId, ltiInstallKeyId) {
  return {
    type: Constants.DELETE_LTI_INSTALL_KEY,
    method: Network.DEL,
    url: `/api/applications/${applicationId}/lti_install_keys/${ltiInstallKeyId}`,
    ltiInstallKeyId,
  };
}
