import { combineReducers } from 'redux';
import settings from 'atomic-fuel/libs/reducers/settings';
import jwt from 'atomic-fuel/libs/reducers/jwt';
import errors from 'atomic-fuel/libs/reducers/errors';

import application from './application';
import applications from './applications';
import applicationInstances from './application_instances';
import ltiInstallKeys from './lti_install_keys';
import sites from './sites';
import siteToOauth from './site_to_oauth';
import accounts from './accounts';
import externalTools from './external_tools';
import courses from './courses';
import loadingCourses from './loading_courses';
import authenticationChecks from './authentication_checks';
import accountAnalytics from '../../../common/reducers/account_analytics';
import platforms from './atomic_admin/atomic_lti_platforms';
import pinnedPlatformGuids from './atomic_admin/pinned_platform_guids';
import pinnedClientIds from './atomic_admin/pinned_client_ids';
import deployments from './atomic_admin/deployments';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  applications,
  applicationInstances,
  ltiInstallKeys,
  sites,
  siteToOauth,
  accounts,
  externalTools,
  courses,
  loadingCourses,
  errors,
  authenticationChecks,
  accountAnalytics,
  platforms,
  pinnedPlatformGuids,
  pinnedClientIds,
  deployments
});

export default rootReducer;
