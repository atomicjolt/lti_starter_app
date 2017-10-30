import { combineReducers } from 'redux';
import settings            from 'atomic-fuel/libs/reducers/settings';
import jwt                 from 'atomic-fuel/libs/reducers/jwt';
import application         from './application';
import contentItemSelection from './content_item_selection';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  contentItemSelection
});

export default rootReducer;
