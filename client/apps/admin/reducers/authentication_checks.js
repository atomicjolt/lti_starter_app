import _             from 'lodash';

import { Constants as ApplicationInstancesConstants } from '../actions/application_instances';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case ApplicationInstancesConstants.CHECK_APPLICATION_INSTANCE_AUTH_DONE: {
      const newState = _.cloneDeep(state);
      newState[action.original.authenticationId] = action.payload;
      return newState;
    }

    default:
      return state;
  }
};
