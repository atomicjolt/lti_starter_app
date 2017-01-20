import React                from 'react';
import { connect }          from 'react-redux';
import Modal                from 'react-modal';
import { hashHistory }      from 'react-router';
import _                    from 'lodash';
import InstanceHeader       from './instance_header';
import Search               from '../common/search';
import InstanceList         from './instance_list';
import Heading              from '../common/heading';
import * as InstanceActions from '../../../actions/instances';
import { getInstructureInstances } from '../../../actions/lti_applications';

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

  static getStyles() {
    return {
      modal: {
        overlay: {
          backgroundColor: 'rgba(0, 0, 0, 0.5)',
        },
        content: {

        }
      }
    };
  }

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

  // search(searchText) {
  //   // TODO: write me
  // }

  // newInstance() {
  //   // TODO: write me
  // }

  render() {
    const styles = BaseInstances.getStyles();
    return (
      <div>
        <Heading
          back={() => hashHistory.goBack()}
          userName={this.props.userName}
        />
        <div className="o-contain o-contain--full">
          <Modal
            isOpen={this.state.modalOpen}
            onAfterOpen={() => {}}
            onRequestClose={() => this.setState({ modalOpen: false })}
            style={styles.modal}
            contentLabel="Modal"
          >
            <h1>Attendance</h1>
          </Modal>
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
