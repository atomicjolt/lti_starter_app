import _             from 'lodash';
import { Constants } from '../actions/accounts';

const initialState = {
  accounts : {},
  loading  : false,
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
      const account = action.original.localData;
      account.sub_accounts = action.payload;
      return state;
    }

    case 'LIST_EXTERNAL_TOOLS_ACCOUNTS_DONE': {
      const account = action.original.localData;
      if (account.external_tools === undefined) {
        account.external_tools = {};
      }
      _.each(action.payload, (tool) => {
        account.external_tools[tool.id] = tool;
      });

      // because we're updating sub accounts, we need a shallow clone to
      // maintain the object references.
      return { ...state };
    }

    case 'CREATE_EXTERNAL_TOOL_ACCOUNTS_DONE': {
      const account = action.original.localData;
      account.external_tools[action.payload.id] = action.payload;
      return { ...state };
    }

    case 'DELETE_EXTERNAL_TOOL_ACCOUNTS_DONE': {
      const account = action.original.localData;
      delete account.external_tools[action.payload.id];
      return { ...state };
    }

    default:
      return state;
  }
};
