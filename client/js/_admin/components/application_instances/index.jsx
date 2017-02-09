import React                           from 'react';
import { connect }                     from 'react-redux';
import _                               from 'lodash';
import history                         from '../../history';
import Header                          from './header';
import List                            from './list';
import Modal                           from './modal';
import Heading                         from '../common/heading';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import { getApplications }             from '../../actions/applications';
import { getSites }                    from '../../actions/sites';

const select = (state, props) => ({
  applicationInstances: _.filter(state.applicationInstances,
    { application_id: parseInt(props.params.applicationId, 10) }),
  applications: state.applications,
  userName: state.settings.display_name,
  settings: state.settings,
  sites: state.sites,
});

export class BaseInstances extends React.Component {
  static propTypes = {
    applicationInstances: React.PropTypes.arrayOf(React.PropTypes.shape({})),
    getApplicationInstances: React.PropTypes.func.isRequired,
    getApplications: React.PropTypes.func.isRequired,
    createApplicationInstance: React.PropTypes.func,
    deleteApplicationInstance: React.PropTypes.func,
    getSites: React.PropTypes.func.isRequired,
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
    if (_.isEmpty(this.props.applications)) {
      this.props.getApplications();
    }
    this.props.getSites();
  }

  render() {
    return (
      <div>
        <Heading
          back={() => history.goBack()}
        />
        <div className="o-contain o-contain--full">
          <Modal
            isOpen={this.state.modalOpen}
            applicationInstances={this.props.applicationInstances}
            closeModal={() => this.setState({ modalOpen: false })}
            sites={this.props.sites}
            createApplicationInstance={this.props.createApplicationInstance}
            application={this.props.applications[this.props.params.applicationId]}
          />
          <Header
            openSettings={() => {}}
            newApplicationInstance={() => this.setState({ modalOpen: true })}
            application={this.props.applications[this.props.params.applicationId]}
          />
          <List
            applicationInstances={this.props.applicationInstances}
            settings={this.props.settings}
            deleteApplicationInstance={this.props.deleteApplicationInstance}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, {
  ...ApplicationInstanceActions, ...{ getApplications }, ...{ getSites }
})(BaseInstances);
