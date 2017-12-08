import { combineReducers } from 'redux';
import settings from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/reducers/jwt';
import errors from 'atomic-fuel/libs/reducers/errors';

import application from './application';
import applications from './applications';
import applicationInstances from './application_instances';
import sites from './sites';
import siteToOauth from './site_to_oauth';
import accounts from './accounts';
import externalTools from './external_tools';
import courses from './courses';
import loadingCourses from './loading_courses';
import authenticationChecks from './authentication_checks';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  applications,
  applicationInstances,
  sites,
  siteToOauth,
  accounts,
  externalTools,
  courses,
  loadingCourses,
  errors,
  authenticationChecks,
});

export default rootReducer;
