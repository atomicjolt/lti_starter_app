import _             from 'lodash';
import { Constants } from '../actions/accounts';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.GET_CANVAS_ACCOUNTS_DONE: {
      const newState = _.cloneDeep(state);
      _.forEach(action.payload.accounts, (account) => {
        if (account.parent_account_id == null) {
          newState[0] = account;
        } else if (_.isUndefined(newState[account.parent_account_id])) {
          newState[account.parent_account_id] = {};
          newState[account.parent_account_id][account.id] = account;
        } else {
          newState[account.parent_account_id][account.id] = account;
        }
      });
      return newState;
    }

    default:
      return state;
  }
};
