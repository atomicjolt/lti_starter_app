// if you use jsx, you have to import React
import React                          from 'react';
import { Router, Route, IndexRoute }  from 'react-router';

import appHistory                     from './history';
import Index                          from './components/layout/index';
import Admin                          from './components/admin/lti_applications/index';
import NotFound                       from './components/common/not_found';
import Instances                      from './components/admin/instances/_instances';
import Installs                       from './components/admin/lti_installs/index';

export default (
  <Router history={appHistory}>
    <Route path="/" component={Index}>
      <IndexRoute component={Admin} />
      <Route path="/instances/:applicationId" component={Instances} />
      <Route path="/installs/:accountId" component={Installs} />
    </Route>
    <Route path="*" component={NotFound} />
  </Router>
);
