import _             from 'lodash';

import { DONE }      from '../../constants/wrapper';

import {
  helperListAccounts,
} from '../../libs/canvas/helper_constants';

const initialState = {
  accounts : {},
  loading  : false,
};

export default (state = initialState, action) => {
  switch (action.type) {

    case `${helperListAccounts.type}${DONE}`: {
      const newState = _.cloneDeep(state);
      newState.loading = false;
      _.forEach(action.payload, (account) => {
        newState.accounts[account.id] = account;
      });

      return newState;
    }

    case helperListAccounts.type: {
      const newState = _.cloneDeep(state);
      newState.loading = _.isEmpty(newState.accounts);

      return newState;
    }

    default:
      return state;
  }
};
