import _ from 'lodash';
import { Constants as LtiInstallKeysConstants } from '../actions/lti_install_keys';

const initialState = {
  ltiInstallKeys: [],
  totalPages: 1,
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
        const keyClone = _.cloneDeep(key);

        keyClone.clientId = keyClone.client_id;
        keyClone.jwksUrl = keyClone.jwks_url;
        keyClone.tokenUrl = keyClone.token_url;
        keyClone.oidcUrl = keyClone.oidc_url;

        delete keyClone.client_id;
        delete keyClone.jwks_url;
        delete keyClone.token_url;
        delete keyClone.oidc_url;

        newState.ltiInstallKeys.push(keyClone);
      });
      newState.totalPages = totalPages;
      return newState;
    }

    case LtiInstallKeysConstants.GET_LTI_INSTALL_KEY_DONE:
    case LtiInstallKeysConstants.SAVE_LTI_INSTALL_KEY_DONE:
    case LtiInstallKeysConstants.CREATE_LTI_INSTALL_KEY_DONE: {
      const newState = _.cloneDeep(state);
      const keyClone = _.cloneDeep(action.payload);

      keyClone.clientId = keyClone.client_id;
      keyClone.jwksUrl = keyClone.jwks_url;
      keyClone.tokenUrl = keyClone.token_url;
      keyClone.oidcUrl = keyClone.oidc_url;

      delete keyClone.client_id;
      delete keyClone.jwks_url;
      delete keyClone.token_url;
      delete keyClone.oidc_url;

      _.remove(newState.ltiInstallKeys, ai => (
        ai.id === action.payload.id
      ));
      newState.ltiInstallKeys.push(keyClone);
      return newState;
    }

    case LtiInstallKeysConstants.DELETE_LTI_INSTALL_KEY_DONE: {
      const newState = _.cloneDeep(state);
      _.remove(newState.ltiInstallKeys, ai => (
        ai.id === action.original.ltiInstallKeyId
      ));
      return newState;
    }

    default:
      return state;
  }
};
