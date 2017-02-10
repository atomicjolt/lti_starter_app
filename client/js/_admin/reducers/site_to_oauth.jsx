import { Constants } from '../actions/sites';

const initialState = null;

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.CREATE_SITE_DONE:
      return action.payload.url;

    default:
      return state;

  }
};
