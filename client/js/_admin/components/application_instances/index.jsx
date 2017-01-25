import React                           from 'react';
import { connect }                     from 'react-redux';
import Modal                           from 'react-modal';
import { hashHistory }                 from 'react-router';
import _                               from 'lodash';
import InstanceHeader                  from './instance_header';
import Search                          from '../common/search';
import InstanceList                    from './instance_list';
import NewInstanceModal                from './new_instance_modal';
import Heading                         from '../common/heading';
import * as ApplicationInstanceActions from '../../actions/application_instances';
import { getApplications }             from '../../actions/applications';

const select = state => ({
  applicationInstances: state.applicationInstances,
  applications: state.applications,
  userName: state.settings.display_name,
});

export class BaseInstances extends React.Component {
  static propTypes = {
    applicationInstances: React.PropTypes.shape({}).isRequired,
    getApplicationInstances: React.PropTypes.func.isRequired,
    getApplications: React.PropTypes.func.isRequired,
    applications: React.PropTypes.shape({}).isRequired,
    params: React.PropTypes.shape({
      applicationId: React.PropTypes.string.isRequired,
    }).isRequired,
    userName: React.PropTypes.string,
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
  }

  render() {
    return (
      <div>
        <Heading
          back={() => hashHistory.goBack()}
          userName={this.props.userName}
        />
        <div className="o-contain o-contain--full">
          <NewInstanceModal
            isOpen={this.state.modalOpen}
            applicationInstances={this.props.applicationInstances}
            closeModal={() => this.setState({ modalOpen: false })}
          />
          <InstanceHeader
            openSettings={() => {}}
            newInstance={() => this.setState({ modalOpen: true })}
            instance={this.props.applications[this.props.params.applicationId]}
          />
          <Search
            search={() => {}}
          />
          <InstanceList
            applicationInstances={this.props.applicationInstances}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, {
  ...ApplicationInstanceActions, ...{ getApplications }
})(BaseInstances);
