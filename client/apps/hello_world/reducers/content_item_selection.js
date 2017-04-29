import { Constants } from '../actions/content_items';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {

    case Constants.CREATE_CONTENT_ITEM_SELECTION_DONE:
      return action.payload;

    default:
      return state;
  }
};
