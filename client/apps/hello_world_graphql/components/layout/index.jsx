import React from 'react';
import PropTypes from 'prop-types';
import { Route, Switch } from 'react-router';
import { withSettings } from 'atomic-fuel/libs/components/settings';

import { displayCanvasAuth } from '../../../../common/components/common/canvas_auth';
import Home from '../home';
import Setup from '../setup';
import NotFound from '../common/not_found';
import { canAdmin } from '../../../../common/utils';

export class Index extends React.Component {

  static propTypes = {
    settings: PropTypes.shape({
      lti_launch_config: PropTypes.shape({
        discussion_id: PropTypes.number,
        title: PropTypes.string
      })
    })
  };

  renderContent() {
    return (
      <div className="app-index">
        <Switch>
          <Route path="/setup" component={Setup} />
          <Route path="/" component={Home} />
          <Route path="*" component={NotFound} />
        </Switch>
      </div>
    );
  }

  render() {
    if (canAdmin(this.props.settings)) {
      return displayCanvasAuth(this.props.settings, false) || this.renderContent();
    }
    return this.renderContent();
  }

}

export default withSettings(Index);
