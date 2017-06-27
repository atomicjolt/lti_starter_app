import { Constants as ContentItemConstants } from '../actions/content_items';
import { Constants as LtiLaunchConstants } from '../actions/lti_launches';

const initialState = {};

export default (state = initialState, action) => {

  switch (action.type) {

    case ContentItemConstants.CREATE_CONTENT_ITEM_SELECTION_DONE:
      return action.payload;

    case LtiLaunchConstants.CREATE_LTI_LAUNCH_DONE:
      return action.payload.content_item_data;

    default:
      return state;
  }
};
