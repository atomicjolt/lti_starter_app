import React                from 'react';
import { connect }          from 'react-redux';
import Modal                from 'react-modal';
import InstanceHeader       from './instance_header';
import Search               from '../common/search';
import InstanceList         from './instance_list';
import * as InstanceActions from '../../../actions/instances';

const select = state => ({
  instances: state.instances,

});

export class Instances extends React.Component {
  static propTypes = {
    instances    : React.PropTypes.shape({}).isRequired,
    getInstances : React.PropTypes.func.isRequired,
  };

  constructor() {
    super();
    this.state = { modalOpen: false };
  }

  componentWillMount() {
    const applicationId = this.props.params.applicationId;
    this.props.getInstructureInstances(applicationId);

  }

  newInstance() {
    // TODO: write me
    console.log('new instance');
  }

  search(searchText) {
    // TODO: write me
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
