import React from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import _ from 'lodash';
import Header from './header';
import List from './list';
import Modal from './modal';
import Heading from '../common/heading';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state, props) => ({
  applicationInstances: _.filter(state.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  userName: state.settings.display_name,
  settings: state.settings,
  sites: state.sites,
  canvasOauthURL: state.settings.canvas_oauth_url,
});

export class Index extends React.Component {
  static propTypes = {
    applicationInstances: PropTypes.arrayOf(PropTypes.shape({})),
    getApplicationInstances: PropTypes.func.isRequired,
    createApplicationInstance: PropTypes.func,
    deleteApplicationInstance: PropTypes.func,
    saveApplicationInstance: PropTypes.func,
    sites: PropTypes.shape({}).isRequired,
    applications: PropTypes.shape({}).isRequired,
    params: PropTypes.shape({
      applicationId: PropTypes.string.isRequired,
    }).isRequired,
    settings: PropTypes.shape({
      canvas_callback_url: PropTypes.string.isRequired,
    }).isRequired,
    canvasOauthURL: PropTypes.string.isRequired,
  };

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  componentWillMount() {
    this.props.getApplicationInstances(this.props.params.applicationId);
  }

  render() {
    const application = this.props.applications[this.props.params.applicationId];

    return (
      <div>
        <Heading backTo="/applications" />
        <div className="o-contain o-contain--full">
          <Modal
            isOpen={this.state.modalOpen}
            closeModal={() => this.setState({ modalOpen: false })}
            sites={this.props.sites}
            save={this.props.createApplicationInstance}
            application={application}
          />
          <Header
            openSettings={() => {}}
            newApplicationInstance={() => this.setState({ modalOpen: true })}
            application={application}
          />
          <List
            applicationInstances={this.props.applicationInstances}
            settings={this.props.settings}
            sites={this.props.sites}
            application={application}
            saveApplicationInstance={this.props.saveApplicationInstance}
            deleteApplicationInstance={this.props.deleteApplicationInstance}
            canvasOauthURL={this.props.canvasOauthURL}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, ApplicationInstanceActions)(Index);
