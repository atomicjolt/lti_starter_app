import { combineReducers } from 'redux';
import settings from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/reducers/jwt';
import errors from 'atomic-fuel/libs/reducers/errors';
import canvasErrors from 'atomic-canvas/libs/reducers/errors';
import courses from 'atomic-canvas/libs/reducers/courses';
import application from './application';
import contentItemSelection from './content_item_selection';
import deepLinkJwt from './deep_link_jwt';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  errors,
  canvasErrors,
  courses,
  contentItemSelection,
  deepLinkJwt,
});

export default rootReducer;
