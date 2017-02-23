// if you use jsx, you have to import React
import React                          from 'react';
import { Router, Route, IndexRoute }  from 'react-router';

import appHistory                     from './history';
import Index                          from './components/layout/index';
import Admin                          from './components/applications/index';
import Installs                       from './components/lti_installs/index';
import ApplicationInstances           from './components/application_instances/index';
import Sites                          from './components/sites/index';

export default (
  <Router history={appHistory}>
    <Route path="/" component={Index}>
      <IndexRoute component={Admin} />
      <Route path="/applications/:applicationId/application_instances" component={ApplicationInstances} />
      <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/installs" component={Installs} />
      <Route path="/sites" component={Sites} />
    </Route>
  </Router>
);
