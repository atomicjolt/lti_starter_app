import { combineReducers } from 'redux';
import settings            from '../../reducers/settings';
import application         from '../../reducers/application';
import jwt                 from '../../reducers/jwt';
import applications        from './applications';
import instances           from './instances';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  applications,
  instances,
});

export default rootReducer;
