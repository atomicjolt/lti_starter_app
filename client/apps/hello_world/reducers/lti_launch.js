import { Constants as LtiLaunchConstants } from '../actions/lti_launches';

const initialState = {};

export default (state = initialState, action) => {

  switch (action.type) {

    case LtiLaunchConstants.CREATE_LTI_LAUNCH_DONE:
      return action.payload;

    default:
      return state;
  }
};
