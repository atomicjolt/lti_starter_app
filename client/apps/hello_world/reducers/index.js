import { combineReducers } from 'redux';
import settings from '../../../libs/reducers/settings';
import jwt from '../../../libs/reducers/jwt';
import application from './application';
import contentItemSelection from './content_item_selection';
import ltiLaunch from './lti_launch';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  contentItemSelection,
  ltiLaunch
});

export default rootReducer;
