import { combineReducers } from 'redux';
import settings            from './settings';
import application         from './application';
import jwt                 from './jwt';
import ltiApplications     from './lti_applications';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  ltiApplications,
});

export default rootReducer;
