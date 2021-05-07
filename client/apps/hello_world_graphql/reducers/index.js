import { combineReducers } from 'redux';

import jwt from 'atomic-fuel/libs/reducers/jwt';
import errors from 'atomic-fuel/libs/reducers/errors';
import canvasErrors from 'atomic-canvas/libs/reducers/errors';

const rootReducer = combineReducers({
  jwt,
  errors,
  canvasErrors,
});

export default rootReducer;
