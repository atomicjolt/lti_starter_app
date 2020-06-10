import _ from 'lodash';
import { Constants as LtiInstallKeysConstants } from '../actions/lti_install_keys';

const initialState = {
  ltiInstallKeys: [],
  totalPages: 1,
};

const translateLtiInstallKey = function (ltiInstallKey) {
  return {
    id: ltiInstallKey.id,
    application_id: ltiInstallKey.application_id,
    created_at: ltiInstallKey.created_at,
    updated_at: ltiInstallKey.updated_at,
    iss: ltiInstallKey.iss,
    clientId: ltiInstallKey.client_id,
    jwksUrl: ltiInstallKey.jwks_url,
    oidcUrl: ltiInstallKey.oidc_url,
    tokenUrl: ltiInstallKey.token_url,
  };
};

export default (state = initialState, action) => {
  switch (action.type) {

    case LtiInstallKeysConstants.GET_LTI_INSTALL_KEYS_DONE: {
      const newState = _.cloneDeep(initialState);
      const {
        lti_install_keys:ltiInstallKeys,
        total_pages:totalPages,
      } = action.payload;
      _.forEach(ltiInstallKeys, (key) => {
        newState.ltiInstallKeys.push(translateLtiInstallKey(key));
      });
      newState.totalPages = totalPages;
      return newState;
    }

    case LtiInstallKeysConstants.GET_LTI_INSTALL_KEY_DONE:
    case LtiInstallKeysConstants.SAVE_LTI_INSTALL_KEY_DONE:
    case LtiInstallKeysConstants.CREATE_LTI_INSTALL_KEY_DONE: {
      const newState = _.cloneDeep(state);

      _.remove(newState.ltiInstallKeys, ltiInstallKey => (
        ltiInstallKey.id === action.payload.id
      ));
      newState.ltiInstallKeys.push(translateLtiInstallKey(action.payload));
      return newState;
    }

    case LtiInstallKeysConstants.DELETE_LTI_INSTALL_KEY_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.ltiInstallKeys, ltiInstallKey => (
        ltiInstallKey.id === action.original.ltiInstallKeyId
      ));
      return newState;
    }

    default:
      return state;
  }
};
