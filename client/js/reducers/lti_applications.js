import _                                        from 'lodash';
import { Constants as LtiApplicationConstants } from '../actions/lti_applications';


const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case LtiApplicationConstants.GET_LTI_APPLICATIONS_DONE:
      const newState = _.cloneDeep(state);
      _.forEach(action.payload.lti_applications, (app) => {
        newState[app.id] = app;
      });
      return newState;

    default:
      return state;

  }
};
