import { Constants } from '../actions/deep_links';

const initialState = {};

export default (state = initialState, action) => {

  switch (action.type) {

    case Constants.CREATE_DEEP_LINK_DONE:
      return action.payload.jwt;

    default:
      return state;
  }
};
