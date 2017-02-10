import { combineReducers }    from 'redux';
import settings               from '../../reducers/settings';
import application            from '../../reducers/application';
import jwt                    from '../../reducers/jwt';
import applications           from './applications';
import applicationInstances   from './application_instances';
import sites                  from './sites';
import siteToOauth            from './site_to_oauth';
import accounts               from './accounts';
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
  courses,
  loadingCourses,
});

export default rootReducer;
