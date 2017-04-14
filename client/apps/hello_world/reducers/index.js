import { combineReducers } from 'redux';
import settings            from '../../../libs/reducers/settings';
import jwt                 from '../../../libs/reducers/jwt';
import application         from '../../../libs/reducers/application';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
});

export default rootReducer;
