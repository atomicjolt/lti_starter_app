// if you use jsx, you have to import React
import React from 'react';
import { Router, Route, IndexRoute } from 'react-router3';

import appHistory from './history';
import Index from './components/layout/index';
import Admin from './components/applications/index';
import Installs from './components/lti_installs/index';
import ApplicationInstances from './components/application_instances/index';
import LtiInstallKeys from './components/lti_install_keys/index';
import Sites from './components/sites/index';
import ApplicationInstanceSettings from './components/application_instance_settings/index';
import Analytics from '../../common/components/account_analytics/_account_analytics';
import GeneralSettings from './components/application_instance_settings/general_settings';
import Configuration from './components/application_instance_settings/configuration';
import XmlConfig from './components/application_instance_settings/xml_config';
import LtiAdvantageSettings from './components/application_instance_settings/lti_advantage_settings';

export default (
  <Router history={appHistory}>
    <Route path="/" component={Index}>
      <Route path="/applications" component={Admin} />
      <Route path="/applications/:applicationId/application_instances" component={ApplicationInstances} />
      <Route path="/applications/:applicationId/lti_install_keys" component={LtiInstallKeys} />
      <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/installs" component={Installs} />
      <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings" component={ApplicationInstanceSettings}>
        <IndexRoute component={Analytics} />
        <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings/analytics" component={Analytics} />
        <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings/generalSettings" component={GeneralSettings} />
        <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings/ltiAdvantage" component={LtiAdvantageSettings} />
        <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings/configuration" component={Configuration} />
        <Route path="/applications/:applicationId/application_instances/:applicationInstanceId/settings/xmlConfig" component={XmlConfig} />
      </Route>
      <Route path="/sites" component={Sites} />
    </Route>
  </Router>
);
