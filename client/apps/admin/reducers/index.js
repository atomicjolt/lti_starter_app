import { combineReducers }    from 'redux';
import settings               from '../../../libs/reducers/settings';
import application            from '../../../libs/reducers/application';
import jwt                    from '../../../libs/reducers/jwt';
import applications           from './applications';
import applicationInstances   from './application_instances';
import sites                  from './sites';
import siteToOauth            from './site_to_oauth';
import accounts               from './accounts';
import externalTools          from './external_tools';
import courses                from './courses';
import loadingCourses         from './loading_courses';

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
});

export default rootReducer;
