import React                from 'react';
import { connect }          from 'react-redux';
import InstanceHeader       from './instance_header';
import Search               from './search';
import InstanceList         from './instance_list';
import * as InstanceActions from '../../../actions/instances';

const select = state => ({
  instances: state.instances,
});

export class Instances extends React.Component {
  static propTypes = {
    instances: React.PropTypes.shape({}).isRequired,
    getInstances: React.PropTypes.func.isRequired,
  };

  componentWillMount() {
    this.props.getInstances();
  }

  search(searchText) {
    // TODO: write me
  }

  render() {
    return (
      <div className="o-contain o-contain--full">
        <InstanceHeader />
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
