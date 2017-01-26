import _             from 'lodash';
import { Constants } from '../actions/sites';

const initialState = {};

export default (state = initialState, action) => {
  let newState = {};

  switch (action.type) {

    case Constants.GET_SITES_DONE:
      newState = _.cloneDeep(state);
      _.forEach(action.payload, (site) => {
        newState[site.id] = site;
      });
      return newState;

    case Constants.CREATE_SITE_DONE:
      newState = _.cloneDeep(state);
      newState[action.payload.id] = action.payload;
      return newState;

    default:
      return state;

  }
};
