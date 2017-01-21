import React                from 'react';
import { connect }          from 'react-redux';
import InstanceHeader       from './instance_header';
import Search               from '../common/search';
import InstanceList         from './instance_list';
import NewInstanceModal     from './new_instance_modal';
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

    this.state = {
      newInstanceModalOpen: false,
    };
  }

  componentWillMount() {
    this.props.getInstances(this.props.params.applicationId);
  }

  newInstance() {
    this.setState({
      newInstanceModalOpen: true,
    });
  }

  closeNewInstanceModal() {
    this.setState({
      newInstanceModalOpen: false,
    });
  }

  search(searchText) {
    // TODO: write me
  }

  render() {

    return (
      <div className="o-contain o-contain--full">
        <InstanceHeader
          openSettings={() => console.log('write me')}
          newInstance={() => this.newInstance()}
          instance={this.props.ltiApplications[this.props.params.applicationId]}
        />
        <Search
          search={text => this.search(text)}
        />
        <InstanceList
          instances={this.props.instances}
        />
        <NewInstanceModal
          isOpen={this.state.newInstanceModalOpen}
          instances={this.props.instances}
          closeModal={() => this.closeNewInstanceModal()}
        />
      </div>
    );
  }
}

export default connect(select, InstanceActions)(Instances);
