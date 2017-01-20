import React                from 'react';
import { connect }          from 'react-redux';
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
    params: React.PropTypes.shape({}).isRequired
  };

  componentWillMount() {
    this.props.getInstances(this.props.params.applicationId);
  }

  newInstance() {
    // TODO: write me
    // console.log('new instance');
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
      </div>
    );
  }
}

export default connect(select, InstanceActions)(Instances);
