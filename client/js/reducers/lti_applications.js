import { Constants as LtiApplicationConstants } from '../actions/lti_applications';

const initialState = [];

export default (state = initialState, action) => {
  switch (action.type) {

    case LtiApplicationConstants.GET_LTI_APPLICATIONS_DONE:
      return action.payload.lti_applications;

    default:
      return state;

  }
};
