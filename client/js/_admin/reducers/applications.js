import _             from 'lodash';
import { Constants } from '../actions/applications';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.GET_APPLICATIONS_DONE:
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (app) => {
        newState[app.id] = app;
      });
      return newState;

    default:
      return state;

  }
};
