import React                from 'react';
import { connect }          from 'react-redux';
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

  componentWillMount() {
    this.props.getInstances(this.props.params.applicationId);
  }

  newInstance() {
    // TODO: write me
    console.log('new instance');
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
