import _ from 'lodash';
import { Constants } from '../actions/applications';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.GET_APPLICATIONS_DONE: {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (app) => {
        const appClone = _.cloneDeep(app);
        appClone.default_config = JSON.stringify(app.default_config);
        newState[app.id] = appClone;
      });
      return newState;
    }

    default:
      return state;

  }
};
