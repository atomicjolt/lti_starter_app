import _             from 'lodash';
import { Constants } from '../actions/accounts';

const initialState = {
  accounts: {},
  loading: false,
};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.GET_CANVAS_ACCOUNTS_DONE: {
      const newState = _.cloneDeep(state);
      newState.loading = false;
      _.forEach(action.payload, (account) => {
        newState.accounts[account.id] = account;
      });

      return newState;
    }

    case Constants.GET_CANVAS_ACCOUNTS: {
      const newState = _.cloneDeep(state);
      newState.loading = _.isEmpty(newState.accounts);

      return newState;
    }

    case 'GET_SUB_ACCOUNTS_OF_ACCOUNT_DONE': {
      action.original.localData["sub_accounts"] = action.payload;
      return state;
    }

    default:
      return state;
  }
};
