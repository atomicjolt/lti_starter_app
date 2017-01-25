import React                from 'react';
import { connect }          from 'react-redux';
import Modal                from 'react-modal';
import { hashHistory }      from 'react-router';
import _                    from 'lodash';
import InstanceHeader       from './instance_header';
import Search               from '../common/search';
import InstanceList         from './instance_list';
import NewInstanceModal     from './new_instance_modal';
import Heading              from '../common/heading';
import * as InstanceActions from '../../../actions/application_instances';
import { getInstructureInstances } from '../../../actions/applications';

const select = state => ({
  instances: state.instances,
  ltiApplications: state.ltiApplications,
  userName: state.settings.display_name,
});

export class BaseInstances extends React.Component {
  static propTypes = {
    instances: React.PropTypes.shape({}).isRequired,
    getInstances: React.PropTypes.func.isRequired,
    getInstructureInstances: React.PropTypes.func.isRequired,
    ltiApplications: React.PropTypes.shape({}).isRequired,
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
    this.props.getInstances(this.props.params.applicationId);
    if (_.isEmpty(this.props.ltiApplications)) {
      this.props.getInstructureInstances();
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
            instances={this.props.instances}
            closeModal={() => this.setState({ modalOpen: false })}
          />
          <InstanceHeader
            openSettings={() => {}}
            newInstance={() => this.setState({ modalOpen: true })}
            instance={this.props.ltiApplications[this.props.params.applicationId]}
          />
          <Search
            search={() => {}}
          />
          <InstanceList
            instances={this.props.instances}
          />
        </div>
      </div>
    );
  }
}

export default connect(select, {
  ...InstanceActions, ...{ getInstructureInstances }
})(BaseInstances);
