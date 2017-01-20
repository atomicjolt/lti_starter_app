import React                from 'react';
import { connect }          from 'react-redux';
import Modal                from 'react-modal';
import InstanceHeader       from './instance_header';
import Search               from '../common/search';
import InstanceList         from './instance_list';
import * as InstanceActions from '../../../actions/instances';

const select = state => ({
  instances: state.instances,
  ltiApplications: state.ltiApplications,
});

export class Instances extends React.Component {
  static propTypes = {
    instances: React.PropTypes.shape({}).isRequired,
    getInstances: React.PropTypes.func.isRequired,
    ltiApplications: React.PropTypes.shape({}).isRequired,
    params: React.PropTypes.shape({
      applicationId: React.PropTypes.string.isRequired,
    }).isRequired
  };

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  componentWillMount() {
    this.props.getInstances(this.props.params.applicationId);
  }

  getStyles() {
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

  search(searchText) {
    // TODO: write me
  }

  newInstance() {
    // TODO: write me
    // console.log('new instance');
  }

  render() {
    const styles = this.getStyles();
    return (
      <div className="o-contain o-contain--full">
        <Modal
          isOpen={this.state.modalOpen}
          onAfterOpen={() => console.log('opened')}
          onRequestClose={() => this.setState({ modalOpen: false })}
          style={styles.modal}
          contentLabel="Modal"
        >
          <h1>Attendance</h1>
        </Modal>
        <InstanceHeader
          openSettings={() => console.log('write me')}
          newInstance={() => this.setState({ modalOpen: true })}
          instance={this.props.ltiApplications[this.props.params.applicationId]}
        />
        <Search
          search={text => this.search(text)}
        />
        <InstanceList
          instances={this.props.instances}
        />
      </div>
    );
  }
}

export default connect(select, InstanceActions)(Instances);
