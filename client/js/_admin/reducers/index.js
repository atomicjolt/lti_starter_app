import { combineReducers }    from 'redux';
import settings               from '../../reducers/settings';
import application            from '../../reducers/application';
import jwt                    from '../../reducers/jwt';
import applications           from './applications';
import applicationInstances   from './application_instances';
import sites                  from './sites';

const rootReducer = combineReducers({
  settings,
  jwt,
  application,
  applications,
  applicationInstances,
  sites,
});

export default rootReducer;
