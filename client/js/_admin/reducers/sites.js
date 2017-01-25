import _             from 'lodash';
import { Constants } from '../actions/sites';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.GET_SITES_DONE:
      const newState = _.cloneDeep(state);
      _.forEach(action.payload, (site) => {
        newState[site.id] = site;
      });
      return newState;

    default:
      return state;

  }
};
