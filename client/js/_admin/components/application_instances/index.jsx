import React                           from 'react';
import { connect }                     from 'react-redux';
import _                               from 'lodash';
import Header                          from './header';
import List                            from './list';
import Modal                           from './modal';
import Heading                         from '../common/heading';
import * as ApplicationInstanceActions from '../../actions/application_instances';

const select = (state, props) => ({
  applicationInstances: _.filter(state.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  userName: state.settings.display_name,
  settings: state.settings,
  sites: state.sites,
});

export class Index extends React.Component {
  static propTypes = {
    applicationInstances: React.PropTypes.arrayOf(React.PropTypes.shape({})),
    getApplicationInstances: React.PropTypes.func.isRequired,
    createApplicationInstance: React.PropTypes.func,
    deleteApplicationInstance: React.PropTypes.func,
    saveApplicationInstance: React.PropTypes.func,
    sites: React.PropTypes.shape({}).isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    params: React.PropTypes.shape({
      applicationId: React.PropTypes.string.isRequired,
    }).isRequired,
    settings: React.PropTypes.shape({}).isRequired,
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
          />
        </div>
      </div>
    );
  }
}

export default connect(select, ApplicationInstanceActions)(Index);
