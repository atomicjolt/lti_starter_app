import { combineReducers } from 'redux';
import settings from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/reducers/jwt';
import errors from 'atomic-fuel/libs/reducers/errors';
import application from './application';
import contentItemSelection from './content_item_selection';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  errors,
  contentItemSelection,
});

export default rootReducer;
