import _ from 'lodash';

import { DONE } from 'atomic-fuel/libs/constants/wrapper';

import {
  listExternalToolsAccounts,
  createExternalToolAccounts,
  deleteExternalToolAccounts,
} from 'atomic-canvas/libs/constants/external_tools';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case `${listExternalToolsAccounts.type}${DONE}`: {
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

    case `${createExternalToolAccounts.type}${DONE}`: {
      const account = action.original.localData;
      account.external_tools[action.payload.id] = action.payload;
      return { ...state };
    }

    case `${deleteExternalToolAccounts.type}${DONE}`: {
      const account = action.original.localData;
      delete account.external_tools[action.payload.id];
      return { ...state };
    }

    default:
      return state;
  }
};
