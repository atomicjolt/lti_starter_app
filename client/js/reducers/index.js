import { combineReducers } from 'redux';
import settings            from './settings';
import application         from './application';
import jwt                 from './jwt';
import ltiApplications     from './lti_applications';
import instances           from './instances';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  ltiApplications,
  instances,
});

export default rootReducer;
