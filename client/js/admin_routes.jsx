// if you use jsx, you have to import React
import React                          from 'react';
import { Router, Route, IndexRoute }  from 'react-router';

import appHistory                     from './history';
import Index                          from './components/layout/index';
import Admin                          from './components/admin/lti_applications/index';
import Installs                       from './components/admin/lti_installs/index';
import NotFound                       from './components/common/not_found';
import Instance                       from './components/admin/instances/_instances';

export default (
  <Router history={appHistory}>
    <Route path="/" component={Index}>
      <IndexRoute component={Admin} />
      <Route path="/applications/:applicationId/instances" component={Instance} />
      <Route path="/instances/:instanceId/installs" component={Installs} />
    </Route>
    <Route path="*" component={NotFound} />
  </Router>
);
