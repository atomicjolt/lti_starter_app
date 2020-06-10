// if you use jsx, you have to import React
import React                          from 'react';
import { Router, Route }              from 'react-router3';

import appHistory                     from './history';
import Index                          from './components/layout/index';
import Admin                          from './components/applications/index';
import Installs                       from './components/lti_installs/index';
import ApplicationInstances           from './components/application_instances/index';
import LtiInstallKeys from './components/lti_install_keys/index';
import Sites                          from './components/sites/index';

export default (
  <Router history={appHistory}>
    <Route path="/" component={Index}>
      <Route path="/applications" component={Admin} />
      <Route path="/applications/:applicationId/application_instances" component={ApplicationInstances} />
      <Route path="/applications/:applicationId/lti_install_keys" component={LtiInstallKeys} />
      <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/installs" component={Installs} />
      <Route path="/sites" component={Sites} />
    </Route>
  </Router>
);
