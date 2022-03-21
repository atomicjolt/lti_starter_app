import { Constants } from '../actions/sites';

const initialState = null;

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.UPDATE_SITE_DONE:
    case Constants.CREATE_SITE_DONE:

      // Only request OAuth dance if all values are present
      if (action.payload.url
        && action.payload.oauth_key
        && action.payload.oauth_secret) {
        return action.payload;
      }
      return state;

    default:
      return state;

  }
};
