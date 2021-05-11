import _ from 'lodash';
import { Constants } from '../actions/account_analytics';

const initialState = {
  stats: {
    uniqueUsers: [],
  },
  shouldShowUniqueUsers: true,
};

export default (state = initialState, action) => {
  let newState = {};

  switch (action.type) {
    case Constants.GET_UNIQUE_USERS:
      newState = _.cloneDeep(state);
      if (!action.isRoot) {
        newState.shouldShowUniqueUsers = false;
      }
      return newState;

    case Constants.GET_UNIQUE_USERS_DONE: {
      newState = _.cloneDeep(state);
      const { unique_users: uniqueUsers, months } = action.response.body;
      if (_.isEmpty(uniqueUsers)) {
        newState.shouldShowUniqueUsers = false;
        return newState;
      }

      newState.stats.uniqueUsers = uniqueUsers;
      newState.stats.months = months;
      return newState;
    }

    default:
      return state;
  }
};
