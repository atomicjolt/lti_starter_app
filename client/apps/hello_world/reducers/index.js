import { combineReducers } from 'redux';
import settings from '../../../libs/reducers/settings';
import jwt from '../../../libs/reducers/jwt';
import application from './application';
import contentItemSelection from './content_item_selection';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  contentItemSelection
});

export default rootReducer;
