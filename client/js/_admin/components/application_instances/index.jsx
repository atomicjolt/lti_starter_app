import React                           from 'react';
import { connect }                     from 'react-redux';
import { hashHistory }                 from 'react-router';
import _                               from 'lodash';
import Header                          from './header';
import List                            from './list';
import Modal                           from './modal';
import Heading                         from '../common/heading';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import { getApplications }             from '../../actions/applications';
import { getSites }                    from '../../actions/sites';

const select = state => ({
  applicationInstances: state.applicationInstances,
  applications: state.applications,
  userName: state.settings.display_name,
  settings: state.settings,
  sites: state.sites,
});

export class BaseInstances extends React.Component {
  static propTypes = {
    applicationInstances: React.PropTypes.shape({}).isRequired,
    getApplicationInstances: React.PropTypes.func.isRequired,
    getApplications: React.PropTypes.func.isRequired,
    getSites: React.PropTypes.func.isRequired,
    sites: React.PropTypes.shape({}).isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    params: React.PropTypes.shape({
      applicationId: React.PropTypes.string.isRequired,
    }).isRequired,
    userName: React.PropTypes.string,
    settings: React.PropTypes.shape({}).isRequired,
  };

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  componentWillMount() {
    this.props.getApplicationInstances(this.props.params.applicationId);
    if (_.isEmpty(this.props.applications)) {
      this.props.getApplications();
    }
    this.props.getSites();
  }

  render() {
    return (
      <div>
        <Heading
          back={() => hashHistory.goBack()}
          userName={this.props.userName}
        />
        <div className="o-contain o-contain--full">
          <Modal
            isOpen={this.state.modalOpen}
            applicationInstances={this.props.applicationInstances}
            closeModal={() => this.setState({ modalOpen: false })}
            sites={this.props.sites}
            createApplicationInstance={this.props.createApplicationInstance}
            applicationId={this.props.params.applicationId}
          />
          <Header
            openSettings={() => {}}
            newApplicationInstance={() => this.setState({ modalOpen: true })}
            instance={this.props.applications[this.props.params.applicationId]}
          />
          <List
            applicationInstances={this.props.applicationInstances}
            settings={this.props.settings}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, {
  ...ApplicationInstanceActions, ...{ getApplications }, ...{ getSites }
})(BaseInstances);
